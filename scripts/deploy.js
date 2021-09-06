async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("Deploy account = ", deployer.address);

    //disp account balance
    console.log("Deployer balance = ", (await deployer.getBalance()).toString());

    const Token = await ethers.getContractFactory("WavePortal");
    const token = await Token.deploy();

    console.log("contract address: ", token.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });