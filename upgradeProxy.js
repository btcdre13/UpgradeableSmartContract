const { ethers, upgrades } = require("hardhat");

const proxyAddress = "0xd4fB30AacBCa3B26b9c7DEDB7e3a70b79Bcb1b1b";

async function main() {
    const TicketMachineV2 = await ethers.getContractFactory("TicketMachineV2");
    const upgraded = await upgrades.upgradeProxy(proxyAddress, TicketMachineV2);

    const implementationAddress = await upgrades.erc1967.getImplementationAddress(proxyAddress);
    
    

    console.log("The current contract owner is: " + await upgraded.owner());
    console.log("Implementation contract address: " + implementationAddress);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
})