const { hexStripZeros } = require("ethers/lib/utils");
async function main() {
    const [owner] = await hre.ethers.getSigners();
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy();
    await waveContract.deployed();
    console.log("Contract deployed to:", waveContract.address);
    console.log("Contract owner is:", owner.address);

    let allWaves = await waveContract.getAllWaves()
    console.log("current stored waves", allWaves)

    let waveTxn = await waveContract.wave("A message!")
    await waveTxn.wait()

    waveTxn = await waveContract.wave("seccond message!")
    await waveTxn.wait()

    allWaves = await waveContract.getAllWaves()
    console.log("current stored waves", allWaves)

}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });