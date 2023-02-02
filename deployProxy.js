const { ethers, upgrades } = require("hardhat");

async function main() {
    const TicketMachineV1 = await ethers.getContractFactory("TicketMachineV1");
    const proxy = await upgrades.deployProxy(TicketMachineV1, [1000]);
    await proxy.deployed();

    const implementationAddress = await upgrades.erc1967.getImplementationAddress(proxy.address);

    console.log(`Proxy contract address: ${proxy.address}`);

    console.log(`Implementation contract address: ${implementationAddress}`);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
})