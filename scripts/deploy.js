async function main() {
    const [deployer] = await ethers.getSigners();
    console.log("Deploy account = ", deployer.address);

    const waveContractFactory = await ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy();
    await waveContract.deployed();
    console.log("contract address: ", waveContract.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });