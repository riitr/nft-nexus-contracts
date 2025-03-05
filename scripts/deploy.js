const hre = require("hardhat");

async function main() {
    const [deployer] = await hre.ethers.getSigners();
    console.log("Deploying contract with account:", deployer.address);

    const paymentTokenAddress = "YOUR_ERC20_ADDRESS"; // Replace with actual ERC20 address
    const feeRecipient = deployer.address; // Marketplace admin

    const NFTMarketplace = await hre.ethers.getContractFactory("NFTMarketplace");
    const nftMarketplace = await NFTMarketplace.deploy(paymentTokenAddress, feeRecipient);
    
    await nftMarketplace.waitForDeployment(); // ✅ Fix: Correct deployment function

    console.log("NFT Marketplace deployed to:", await nftMarketplace.getAddress());
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});