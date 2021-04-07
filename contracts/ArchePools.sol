import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract ArChe_Pools is Ownable {
    using SafeMath for uint;
    using SafeERC20 for IERC20;
    event EVENT_STACK(address indexed user, uint tokens);
    event EVENT_RECEIVE(address indexed user, uint tokens);
    event EVENT_UNSTACK(address indexed user, uint tokens);

    struct User {
        bool[5] Registered;
        //Whether to pledge
        //User address
        address[5] User_Address;
        //Total pledge
        uint256[5] Stacking_Amount;
        //Total rewards
        uint256[5] Token_Amount;
        uint256[5] Stacking_Block_Number_Start;
        uint256[5] m_LastUpdatedSumOfWeightedStackingReciprocale128;
    }

    struct Pool {
        //The address used to pledge the token
        IERC20 m_Stacking_Address;
        //The address of the reward token
        IERC20 m_Token_Address;
        //Global_Stacking_Block_Number_Start
        uint m_Stacking_Block_Number_Start;
        //Global_Stacking_Block_Number_Stop
        uint m_Stacking_Block_Number_Stop;
        //Global_Total_Stacking
        uint256 m_Total_Stacking;
        //Global_User_Count
        uint256 m_User_Count;
        //Global_WeightOfBlock
        uint256 m_WeightOfBlock;
        //Global_BlockNumOfLastUpdate
        uint256 m_BlockNumOfLastUpdate;
        //Global_SumOfWeightedStackingReciprocale128
        uint256 m_SumOfWeightedStackingReciprocale128;
        //Global_FIX_POINT
        uint256 m_FIX_POINT;
    }

    Pool[] public m_Pool_Map;

    mapping(address => User)  m_User_Map;

    //Registration only
    modifier OnlyRegistered(uint256 period_id){
        require(m_User_Map[msg.sender].Registered[period_id] == true);
        _;
    }


    function Add_PoolInfo(IERC20 StackingAddress, IERC20 TokenAddress) public onlyOwner {
        Pool memory poolInfo = Pool(
            StackingAddress,
            TokenAddress,
            block.number,
            0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF,
            100,
            1,
            26130510402033580,
            block.number,
            0,
            (1 * 2 ** 128));

        m_Pool_Map.push(poolInfo);
    }

    //------------------------------------Business class------------------------------------
    /*
    Initialize user
    Incoming period_id
    */
    function Do_Registering(uint period_id) internal {
        m_User_Map[msg.sender].Registered[period_id] = true;
        m_User_Map[msg.sender].User_Address[period_id] = msg.sender;
        m_User_Map[msg.sender].Stacking_Block_Number_Start[period_id] = block.number;
        m_User_Map[msg.sender].m_LastUpdatedSumOfWeightedStackingReciprocale128[period_id] = m_Pool_Map[period_id].m_SumOfWeightedStackingReciprocale128;

    }

    /*
    Pledge
    Incoming period_id,stacking_amount
    */
    function Do_Stacking(uint period_id, uint stacking_amount) external returns (bool){
        if (m_User_Map[msg.sender].Registered[period_id] == false) Do_Registering(period_id);
        m_Pool_Map[period_id].m_Stacking_Address.safeTransferFrom(msg.sender, address(this), stacking_amount);

        uint256 old_stacking_amount = m_User_Map[msg.sender].Stacking_Amount[period_id];
        Update_Global_Data(period_id);
        Update_User(msg.sender, period_id);
        (, m_Pool_Map[period_id].m_Total_Stacking) = m_Pool_Map[period_id].m_Total_Stacking.tryAdd(stacking_amount);
        (, m_User_Map[msg.sender].Stacking_Amount[period_id]) = m_User_Map[msg.sender].Stacking_Amount[period_id].tryAdd(stacking_amount);
        if (old_stacking_amount < 10 && m_User_Map[msg.sender].Stacking_Amount[period_id] >= 10) {
            (, m_Pool_Map[period_id].m_User_Count) = m_Pool_Map[period_id].m_User_Count.tryAdd(1);
        }
        emit EVENT_STACK(msg.sender, stacking_amount);
        return true;
    }

    /*
    Do harvest
    Incoming period_id
    */
    function Do_Receiving(uint period_id) public OnlyRegistered(period_id) returns (bool) {
        Update_Global_Data(period_id);
        Update_User(msg.sender, period_id);
        m_Pool_Map[period_id].m_Token_Address.safeTransfer(msg.sender, m_User_Map[msg.sender].Token_Amount[period_id]);
        emit EVENT_RECEIVE(msg.sender, m_User_Map[msg.sender].Token_Amount[period_id]);
        m_User_Map[msg.sender].Token_Amount[period_id] = 0;
        return true;
    }

    /*
    Release pledge
    Incoming period_id
    */
    function Do_Unstacking(uint period_id) external OnlyRegistered(period_id) returns (bool)  {
        require(m_User_Map[msg.sender].Registered[period_id] == true, "You have not Stacking");
        Update_Global_Data(period_id);
        Update_User(msg.sender, period_id);
        uint256 old_stacking_amount = m_User_Map[msg.sender].Stacking_Amount[period_id];
        m_Pool_Map[period_id].m_Stacking_Address.safeTransfer(msg.sender, old_stacking_amount);
        Do_Receiving(period_id);
        (, m_User_Map[msg.sender].Stacking_Amount[period_id]) = m_User_Map[msg.sender].Stacking_Amount[period_id].trySub(old_stacking_amount);
        (, m_Pool_Map[period_id].m_Total_Stacking) = m_Pool_Map[period_id].m_Total_Stacking.trySub(old_stacking_amount);
        if (old_stacking_amount >= 10 && m_User_Map[msg.sender].Stacking_Amount[period_id] < 10) {
            (, m_Pool_Map[period_id].m_User_Count) = m_Pool_Map[period_id].m_User_Count.trySub(1);
            m_User_Map[msg.sender].Registered[period_id] = false;
        }
        emit EVENT_UNSTACK(msg.sender, old_stacking_amount);
        return true;
    }


    /*
    Update global data
    */
    function Update_Global_Data(uint period_id) internal {
        uint block_num_clamp = block.number;
        if (block_num_clamp > m_Pool_Map[period_id].m_Stacking_Block_Number_Stop) {
            block_num_clamp = m_Pool_Map[period_id].m_Stacking_Block_Number_Stop;
        }
        if (block_num_clamp < m_Pool_Map[period_id].m_Stacking_Block_Number_Start) {
            block_num_clamp = m_Pool_Map[period_id].m_Stacking_Block_Number_Start;
        }
        (, uint256 block_span) = block_num_clamp.trySub(m_Pool_Map[period_id].m_BlockNumOfLastUpdate);
        if (block_span != 0) {
            uint256 delta = m_Pool_Map[period_id].m_FIX_POINT;
            uint256 t_total_stacking = m_Pool_Map[period_id].m_Total_Stacking;
            (, delta) = delta.tryDiv(t_total_stacking);
            (, delta) = delta.mul(block_span).tryMul(m_Pool_Map[period_id].m_WeightOfBlock);
            (, m_Pool_Map[period_id].m_SumOfWeightedStackingReciprocale128) = m_Pool_Map[period_id].m_SumOfWeightedStackingReciprocale128.tryAdd(delta);
        }
        m_Pool_Map[period_id].m_BlockNumOfLastUpdate = block_num_clamp;

    }

    /*
    Update user
    Incoming user address
    */
    function Update_User(address user, uint period_id) internal {
        if (m_User_Map[user].Registered[period_id] == false) {
            return;
        }
        uint block_num_clamp = block.number;
        if (block_num_clamp > m_Pool_Map[period_id].m_Stacking_Block_Number_Stop) {
            block_num_clamp = m_Pool_Map[period_id].m_Stacking_Block_Number_Stop;
        }
        m_User_Map[user].User_Address[period_id] = user;
        if (m_User_Map[user].Stacking_Block_Number_Start[period_id] <= m_Pool_Map[period_id].m_Stacking_Block_Number_Start) {
            m_User_Map[user].Stacking_Block_Number_Start[period_id] = block_num_clamp;
        }
        if (m_User_Map[user].Stacking_Block_Number_Start[period_id] > block_num_clamp) {
            m_User_Map[user].Stacking_Block_Number_Start[period_id] = block_num_clamp;
        }
        if (m_User_Map[user].Stacking_Block_Number_Start[period_id] >= m_Pool_Map[period_id].m_Stacking_Block_Number_Stop) {
            m_User_Map[user].Stacking_Block_Number_Start[period_id] = m_Pool_Map[period_id].m_Stacking_Block_Number_Stop;
        }
        uint fixed_point = (2 ** 12);
        (, uint quantity) = m_Pool_Map[period_id].m_SumOfWeightedStackingReciprocale128.trySub(m_User_Map[user].m_LastUpdatedSumOfWeightedStackingReciprocale128[period_id]);
        (, quantity) = quantity.tryDiv(fixed_point);
        (, quantity) = (m_User_Map[user].Stacking_Amount[period_id]).tryMul(quantity);
        (, quantity) = quantity.tryDiv(m_Pool_Map[period_id].m_FIX_POINT);
        (, quantity) = quantity.tryMul(fixed_point);
        (, quantity) = quantity.tryMul(10);
        (, quantity) = quantity.tryDiv(10);
        (, m_User_Map[user].Token_Amount[period_id]) = m_User_Map[user].Token_Amount[period_id].tryAdd(quantity);
        m_User_Map[user].Stacking_Block_Number_Start[period_id] = block_num_clamp;
        m_User_Map[user].m_LastUpdatedSumOfWeightedStackingReciprocale128[period_id] = m_Pool_Map[period_id].m_SumOfWeightedStackingReciprocale128;

    }
    //------------------------------------View class------------------------------------
    /*
    View receipt
    Incoming user address
    */
    function ViewReceiving(uint period_id, address user) external view returns (uint) {
        ////Get how many blocks between last operation and current block///
        uint block_num_clamp = block.number;
        if (block_num_clamp > m_Pool_Map[period_id].m_Stacking_Block_Number_Stop)
        {
            block_num_clamp = m_Pool_Map[period_id].m_Stacking_Block_Number_Stop;
        }
        if (block_num_clamp < m_Pool_Map[period_id].m_Stacking_Block_Number_Start)
        {
            block_num_clamp = m_Pool_Map[period_id].m_Stacking_Block_Number_Start;
        }
        (, uint256 block_span) = block_num_clamp.trySub(m_Pool_Map[period_id].m_BlockNumOfLastUpdate);
        uint256 t_SumOfWeightedStackingReciprocale128 = m_Pool_Map[period_id].m_SumOfWeightedStackingReciprocale128;
        if (block_span != 0) {
            uint256 delta = m_Pool_Map[period_id].m_FIX_POINT;
            uint256 t_total_stacking = m_Pool_Map[period_id].m_Total_Stacking;
            (, delta) = delta.tryDiv(t_total_stacking);
            (, delta) = delta.mul(block_span).tryMul(m_Pool_Map[period_id].m_WeightOfBlock);
            (, t_SumOfWeightedStackingReciprocale128) = m_Pool_Map[period_id].m_SumOfWeightedStackingReciprocale128.tryAdd(delta);
        }
        ////BASE///////////////////////////////////////////////////////////////
        uint fixed_point = (2 ** 12);
        (, uint quantity) = t_SumOfWeightedStackingReciprocale128.trySub(m_User_Map[user].m_LastUpdatedSumOfWeightedStackingReciprocale128[period_id]);
        (, quantity) = quantity.tryDiv(fixed_point);
        (, quantity) = (m_User_Map[user].Stacking_Amount[period_id]).tryMul(quantity);
        (, quantity) = quantity.tryDiv(m_Pool_Map[period_id].m_FIX_POINT);
        (, quantity) = quantity.tryMul(fixed_point);
        ////////)//////////////////////////////
        (, quantity) = quantity.tryMul(10);
        (, quantity) = quantity .tryDiv(10);
        (, uint res) = quantity .tryAdd(m_User_Map[user].Token_Amount[period_id]);
        return res;
    }

    /*
    Get user information
    Incoming user address
    */
    function Get_User_Info(address user) external view returns (address, bool[5] memory, uint[5] memory, uint[5] memory, uint[5] memory){
        return (
        user,
        m_User_Map[user].Registered,
        m_User_Map[user].Stacking_Block_Number_Start,
        m_User_Map[user].Stacking_Amount,
        m_User_Map[user].Token_Amount
        );
    }

    /*
    Get game information
    */
    function Get_Game_Info(uint256 period_id) external view returns (IERC20, IERC20, uint256, uint256){
        return (
        m_Pool_Map[period_id].m_Stacking_Address,
        m_Pool_Map[period_id].m_Token_Address,
        m_Pool_Map[period_id].m_Total_Stacking,
        m_Pool_Map[period_id].m_User_Count
        );
    }
}
