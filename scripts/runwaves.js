const { hexStripZeros } = require("ethers/lib/utils");
async function main() {
    const [owner] = await hre.ethers.getSigners();
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy({value: hre.ethers.utils.parseEther("0.01")});
    await waveContract.deployed();
    console.log("Contract deployed to:", waveContract.address);
    console.log("Contract owner is:", owner.address);

    let contractBalance = await hre.ethers.provider.getBalance(waveContract.address)
    console.log("contract balance = ", hre.ethers.utils.formatEther(contractBalance))

    let allWaves = await waveContract.getAllWaves()
    console.log("current stored waves", allWaves)

    let waveTxn = await waveContract.wave("A message!")
    await waveTxn.wait()

    waveTxn = await waveContract.wave("seccond message!")
    await waveTxn.wait()

    allWaves = await waveContract.getAllWaves()
    console.log("current stored waves", allWaves)

    contractBalance = await hre.ethers.provider.getBalance(waveContract.address)
    console.log("contract balance = ", hre.ethers.utils.formatEther(contractBalance))
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });