async function main() {

    const [deployer] = await ethers.getSigners();

    console.log("Current contract deployer:", deployer.address);

    console.log("Contract deployer balance:", (await deployer.getBalance()).toString());
    
    //-------------------------------------------------
    const ArChe_Pools = await ethers.getContractFactory("ArChe_Pools");

    const arChe_Pools = await ArChe_Pools.deploy();

    console.log("ArChe_Pools_Remix address:", arChe_Pools.address);
    //-------------------------------------------------
    const InitializableImmutableAdminUpgradeabilityProxy = await ethers.getContractFactory("InitializableImmutableAdminUpgradeabilityProxy");

    const initializableImmutableAdminUpgradeabilityProxy = await InitializableImmutableAdminUpgradeabilityProxy.deploy(deployer.address);

    console.log("initializableImmutableAdminUpgradeabilityProxy address:", initializableImmutableAdminUpgradeabilityProxy.address);
    //-------------------------------------------------
    initializableImmutableAdminUpgradeabilityProxy.initialize(arChe_Pools.address,"");
}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });
