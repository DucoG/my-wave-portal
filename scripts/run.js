const { hexStripZeros } = require("ethers/lib/utils");
async function main() {

    //Get owner
    const [owner, rand1, rand2, rand3] = await ethers.getSigners();
    
    //deploy
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy();
    await waveContract.deployed();
    console.log("Contract deployed to:", waveContract.address);
    console.log("Contract owner is:", owner.address);

    let registrationTxn = await waveContract.connect(owner).register("duuxster")
    await registrationTxn.wait()

    let userdata = await waveContract.getAllUserData()
    console.log(userdata)

    registrationTxn = await waveContract.connect(rand1).register("rand1")
    await registrationTxn.wait()

    registrationTxn = await waveContract.connect(rand2).register("rand2")
    await registrationTxn.wait()

    userdata = await waveContract.getAllUserData()
    console.log(userdata)

    console.log("sending msg")
    let waveTxn = await waveContract.wave("rand1", "This is a cool message", 0)
    await waveTxn.wait()

    userdata = await waveContract.getAllUserData()
    console.log(userdata)

    console.log("waves1")
    let outgoing = await waveContract.getOutgoingWaves()
    console.log(outgoing)
    let incomming = await waveContract.getIncommingWaves()
    console.log(incomming)

    console.log("waves2")
    outgoing = await waveContract.connect(rand1).getOutgoingWaves()
    console.log(outgoing)
    incomming = await waveContract.connect(rand1).getIncommingWaves()
    console.log(incomming)

    console.log("waves3")

    outgoing = await waveContract.connect(rand2).getOutgoingWaves()
    console.log(outgoing)
    incomming = await waveContract.connect(rand2).getIncommingWaves()
    console.log(incomming)

    registrationTxn = await waveContract.connect(rand3).register("d")
    await waveTxn.wait()


    /*
    //testing
    let allWaves = await waveContract.getAllWaves()
    console.log("current stored waves", allWaves)

    let waveTxn = await waveContract.wave("A message!")
    await waveTxn.wait()

    waveTxn = await waveContract.wave("seccond message!")
    await waveTxn.wait()

    allWaves = await waveContract.getAllWaves()
    console.log("current stored waves", allWaves)
    */
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });