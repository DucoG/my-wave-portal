const { hexStripZeros } = require("ethers/lib/utils");

async function main() {
    const [owner, randoPerson] = await ethers.getSigners();
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy();
    await waveContract.deployed();
    console.log("Contract deployed to:", waveContract.address);
    console.log("Contract owner is:", owner.address);

    let waveCount = await waveContract.getWaveCounter();
    console.log(waveCount);

    let waveTxn = await waveContract.wave();
    await waveTxn.wait();

    waveCount = await waveContract.getWaveCounter();
    console.log(waveCount);




}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });