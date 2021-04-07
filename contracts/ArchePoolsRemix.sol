abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        this;
        // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
        uint256 c = a + b;
        if (c < a) return (false, 0);
        return (true, c);
    }
}

/**
 * @dev Returns the substraction of two unsigned integers, with an overflow flag.
 *
 * _Available since v3.4._
 */
function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
unchecked {
if (b > a) return (false, 0);
return (true, a - b);
}
}

/**
 * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
 *
 * _Available since v3.4._
 */
function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
unchecked {
// Gas optimization: this is cheaper than requiring 'a' not being zero, but the
// benefit is lost if 'b' is also tested.
// See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
if (a == 0) return (true, 0);
uint256 c = a * b;
if (c / a != b) return (false, 0);
return (true, c);
}
}

/**
 * @dev Returns the division of two unsigned integers, with a division by zero flag.
 *
 * _Available since v3.4._
 */
function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
unchecked {
if (b == 0) return (false, 0);
return (true, a / b);
}
}

/**
 * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
 *
 * _Available since v3.4._
 */
function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
unchecked {
if (b == 0) return (false, 0);
return (true, a % b);
}
}

/**
 * @dev Returns the addition of two unsigned integers, reverting on
 * overflow.
 *
 * Counterpart to Solidity's `+` operator.
 *
 * Requirements:
 *
 * - Addition cannot overflow.
 */
function add(uint256 a, uint256 b) internal pure returns (uint256) {
return a + b;
}

/**
 * @dev Returns the subtraction of two unsigned integers, reverting on
 * overflow (when the result is negative).
 *
 * Counterpart to Solidity's `-` operator.
 *
 * Requirements:
 *
 * - Subtraction cannot overflow.
 */
function sub(uint256 a, uint256 b) internal pure returns (uint256) {
return a - b;
}

/**
 * @dev Returns the multiplication of two unsigned integers, reverting on
 * overflow.
 *
 * Counterpart to Solidity's `*` operator.
 *
 * Requirements:
 *
 * - Multiplication cannot overflow.
 */
function mul(uint256 a, uint256 b) internal pure returns (uint256) {
return a * b;
}

/**
 * @dev Returns the integer division of two unsigned integers, reverting on
 * division by zero. The result is rounded towards zero.
 *
 * Counterpart to Solidity's `/` operator.
 *
 * Requirements:
 *
 * - The divisor cannot be zero.
 */
function div(uint256 a, uint256 b) internal pure returns (uint256) {
return a / b;
}

/**
 * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
 * reverting when dividing by zero.
 *
 * Counterpart to Solidity's `%` operator. This function uses a `revert`
 * opcode (which leaves remaining gas untouched) while Solidity uses an
 * invalid opcode to revert (consuming all remaining gas).
 *
 * Requirements:
 *
 * - The divisor cannot be zero.
 */
function mod(uint256 a, uint256 b) internal pure returns (uint256) {
return a % b;
}

/**
 * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
 * overflow (when the result is negative).
 *
 * CAUTION: This function is deprecated because it requires allocating memory for the error
 * message unnecessarily. For custom revert reasons use {trySub}.
 *
 * Counterpart to Solidity's `-` operator.
 *
 * Requirements:
 *
 * - Subtraction cannot overflow.
 */
function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
unchecked {
require(b <= a, errorMessage);
return a - b;
}
}

/**
 * @dev Returns the integer division of two unsigned integers, reverting with custom message on
 * division by zero. The result is rounded towards zero.
 *
 * Counterpart to Solidity's `%` operator. This function uses a `revert`
 * opcode (which leaves remaining gas untouched) while Solidity uses an
 * invalid opcode to revert (consuming all remaining gas).
 *
 * Counterpart to Solidity's `/` operator. Note: this function uses a
 * `revert` opcode (which leaves remaining gas untouched) while Solidity
 * uses an invalid opcode to revert (consuming all remaining gas).
 *
 * Requirements:
 *
 * - The divisor cannot be zero.
 */
function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
unchecked {
require(b > 0, errorMessage);
return a / b;
}
}

/**
 * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
 * reverting with custom message when dividing by zero.
 *
 * CAUTION: This function is deprecated because it requires allocating memory for the error
 * message unnecessarily. For custom revert reasons use {tryMod}.
 *
 * Counterpart to Solidity's `%` operator. This function uses a `revert`
 * opcode (which leaves remaining gas untouched) while Solidity uses an
 * invalid opcode to revert (consuming all remaining gas).
 *
 * Requirements:
 *
 * - The divisor cannot be zero.
 */
function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
unchecked {
require(b > 0, errorMessage);
return a % b;
}
}
}
interface IERC20 {
/**
 * @dev Returns the amount of tokens in existence.
 */
function totalSupply() external view returns (uint256);

/**
 * @dev Returns the amount of tokens owned by `account`.
 */
function balanceOf(address account) external view returns (uint256);

/**
 * @dev Moves `amount` tokens from the caller's account to `recipient`.
 *
 * Returns a boolean value indicating whether the operation succeeded.
 *
 * Emits a {Transfer} event.
 */
function transfer(address recipient, uint256 amount) external returns (bool);

/**
 * @dev Returns the remaining number of tokens that `spender` will be
 * allowed to spend on behalf of `owner` through {transferFrom}. This is
 * zero by default.
 *
 * This value changes when {approve} or {transferFrom} are called.
 */
function allowance(address owner, address spender) external view returns (uint256);

/**
 * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
 *
 * Returns a boolean value indicating whether the operation succeeded.
 *
 * IMPORTANT: Beware that changing an allowance with this method brings the risk
 * that someone may use both the old and the new allowance by unfortunate
 * transaction ordering. One possible solution to mitigate this race
 * condition is to first reduce the spender's allowance to 0 and set the
 * desired value afterwards:
 * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
 *
 * Emits an {Approval} event.
 */
function approve(address spender, uint256 amount) external returns (bool);

/**
 * @dev Moves `amount` tokens from `sender` to `recipient` using the
 * allowance mechanism. `amount` is then deducted from the caller's
 * allowance.
 *
 * Returns a boolean value indicating whether the operation succeeded.
 *
 * Emits a {Transfer} event.
 */
function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

/**
 * @dev Emitted when `value` tokens are moved from one account (`from`) to
 * another (`to`).
 *
 * Note that `value` may be zero.
 */
event Transfer(address indexed from, address indexed to, uint256 value);

/**
 * @dev Emitted when the allowance of a `spender` for an `owner` is set by
 * a call to {approve}. `value` is the new allowance.
 */
event Approval(address indexed owner, address indexed spender, uint256 value);
}
abstract contract Ownable is Context {
address private _owner;

event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

/**
 * @dev Initializes the contract setting the deployer as the initial owner.
 */
constructor () {
address msgSender = _msgSender();
_owner = msgSender;
emit OwnershipTransferred(address(0), msgSender);
}

/**
 * @dev Returns the address of the current owner.
 */
function owner() public view virtual returns (address) {
return _owner;
}

/**
 * @dev Throws if called by any account other than the owner.
 */
modifier onlyOwner() {
require(owner() == _msgSender(), "Ownable: caller is not the owner");
_;
}

/**
 * @dev Leaves the contract without owner. It will not be possible to call
 * `onlyOwner` functions anymore. Can only be called by the current owner.
 *
 * NOTE: Renouncing ownership will leave the contract without an owner,
 * thereby removing any functionality that is only available to the owner.
 */
function renounceOwnership() public virtual onlyOwner {
emit OwnershipTransferred(_owner, address(0));
_owner = address(0);
}

/**
 * @dev Transfers ownership of the contract to a new account (`newOwner`).
 * Can only be called by the current owner.
 */
function transferOwnership(address newOwner) public virtual onlyOwner {
require(newOwner != address(0), "Ownable: new owner is the zero address");
emit OwnershipTransferred(_owner, newOwner);
_owner = newOwner;
}
}
library Address {
/**
 * @dev Returns true if `account` is a contract.
 *
 * [IMPORTANT]
 * ====
 * It is unsafe to assume that an address for which this function returns
 * false is an externally-owned account (EOA) and not a contract.
 *
 * Among others, `isContract` will return false for the following
 * types of addresses:
 *
 *  - an externally-owned account
 *  - a contract in construction
 *  - an address where a contract will be created
 *  - an address where a contract lived, but was destroyed
 * ====
 */
function isContract(address account) internal view returns (bool) {
// This method relies on extcodesize, which returns 0 for contracts in
// construction, since the code is only stored at the end of the
// constructor execution.

uint256 size;
// solhint-disable-next-line no-inline-assembly
assembly {size := extcodesize(account)}
return size > 0;
}

/**
 * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
 * `recipient`, forwarding all available gas and reverting on errors.
 *
 * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
 * of certain opcodes, possibly making contracts go over the 2300 gas limit
 * imposed by `transfer`, making them unable to receive funds via
 * `transfer`. {sendValue} removes this limitation.
 *
 * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
 *
 * IMPORTANT: because control is transferred to `recipient`, care must be
 * taken to not create reentrancy vulnerabilities. Consider using
 * {ReentrancyGuard} or the
 * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
 */
function sendValue(address payable recipient, uint256 amount) internal {
require(address(this).balance >= amount, "Address: insufficient balance");

// solhint-disable-next-line avoid-low-level-calls, avoid-call-value
(bool success,) = recipient.call{value : amount}("");
require(success, "Address: unable to send value, recipient may have reverted");
}

/**
 * @dev Performs a Solidity function call using a low level `call`. A
 * plain`call` is an unsafe replacement for a function call: use this
 * function instead.
 *
 * If `target` reverts with a revert reason, it is bubbled up by this
 * function (like regular Solidity function calls).
 *
 * Returns the raw returned data. To convert to the expected return value,
 * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
 *
 * Requirements:
 *
 * - `target` must be a contract.
 * - calling `target` with `data` must not revert.
 *
 * _Available since v3.1._
 */
function functionCall(address target, bytes memory data) internal returns (bytes memory) {
return functionCall(target, data, "Address: low-level call failed");
}

/**
 * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
 * `errorMessage` as a fallback revert reason when `target` reverts.
 *
 * _Available since v3.1._
 */
function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
return functionCallWithValue(target, data, 0, errorMessage);
}

/**
 * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
 * but also transferring `value` wei to `target`.
 *
 * Requirements:
 *
 * - the calling contract must have an ETH balance of at least `value`.
 * - the called Solidity function must be `payable`.
 *
 * _Available since v3.1._
 */
function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
}

/**
 * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
 * with `errorMessage` as a fallback revert reason when `target` reverts.
 *
 * _Available since v3.1._
 */
function functionCallWithValue(address target, bytes memory data, uint256 value, string memory errorMessage) internal returns (bytes memory) {
require(address(this).balance >= value, "Address: insufficient balance for call");
require(isContract(target), "Address: call to non-contract");

// solhint-disable-next-line avoid-low-level-calls
(bool success, bytes memory returndata) = target.call{value : value}(data);
return _verifyCallResult(success, returndata, errorMessage);
}

/**
 * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
 * but performing a static call.
 *
 * _Available since v3.3._
 */
function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
return functionStaticCall(target, data, "Address: low-level static call failed");
}

/**
 * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
 * but performing a static call.
 *
 * _Available since v3.3._
 */
function functionStaticCall(address target, bytes memory data, string memory errorMessage) internal view returns (bytes memory) {
require(isContract(target), "Address: static call to non-contract");

// solhint-disable-next-line avoid-low-level-calls
(bool success, bytes memory returndata) = target.staticcall(data);
return _verifyCallResult(success, returndata, errorMessage);
}

/**
 * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
 * but performing a delegate call.
 *
 * _Available since v3.4._
 */
function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
return functionDelegateCall(target, data, "Address: low-level delegate call failed");
}

/**
 * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
 * but performing a delegate call.
 *
 * _Available since v3.4._
 */
function functionDelegateCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
require(isContract(target), "Address: delegate call to non-contract");

// solhint-disable-next-line avoid-low-level-calls
(bool success, bytes memory returndata) = target.delegatecall(data);
return _verifyCallResult(success, returndata, errorMessage);
}

function _verifyCallResult(bool success, bytes memory returndata, string memory errorMessage) private pure returns (bytes memory) {
if (success) {
return returndata;
} else {
// Look for revert reason and bubble it up if present
if (returndata.length > 0) {
// The easiest way to bubble the revert reason is using memory via assembly

// solhint-disable-next-line no-inline-assembly
assembly {
let returndata_size := mload(returndata)
revert(add(32, returndata), returndata_size)
}
} else {
revert(errorMessage);
}
}
}
}
library SafeERC20 {
using Address for address;

function safeTransfer(IERC20 token, address to, uint256 value) internal {
_callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
}

function safeTransferFrom(IERC20 token, address from, address to, uint256 value) internal {
_callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
}

/**
 * @dev Deprecated. This function has issues similar to the ones found in
 * {IERC20-approve}, and its usage is discouraged.
 *
 * Whenever possible, use {safeIncreaseAllowance} and
 * {safeDecreaseAllowance} instead.
 */
function safeApprove(IERC20 token, address spender, uint256 value) internal {
// safeApprove should only be called when setting an initial allowance,
// or when resetting it to zero. To increase and decrease it, use
// 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
// solhint-disable-next-line max-line-length
require((value == 0) || (token.allowance(address(this), spender) == 0),
"SafeERC20: approve from non-zero to non-zero allowance"
);
_callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
}

function safeIncreaseAllowance(IERC20 token, address spender, uint256 value) internal {
uint256 newAllowance = token.allowance(address(this), spender) + value;
_callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
}

function safeDecreaseAllowance(IERC20 token, address spender, uint256 value) internal {
unchecked {
uint256 oldAllowance = token.allowance(address(this), spender);
require(oldAllowance >= value, "SafeERC20: decreased allowance below zero");
uint256 newAllowance = oldAllowance - value;
_callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
}
}

/**
 * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
 * on the return value: the return value is optional (but if data is returned, it must not be false).
 * @param token The token targeted by the call.
 * @param data The call data (encoded using abi.encode or one of its variants).
 */
function _callOptionalReturn(IERC20 token, bytes memory data) private {
// We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
// we're implementing it ourselves. We use {Address.functionCall} to perform this call, which verifies that
// the target address contains contract code and also asserts for success in the low-level call.

bytes memory returndata = address(token).functionCall(data, "SafeERC20: low-level call failed");
if (returndata.length > 0) {// Return data is optional
// solhint-disable-next-line max-line-length
require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
}
}
}


contract ArChe_Pools_Remix is Ownable {
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
