# 📌 NFT Nexus Contracts

Welcome to **NFT Nexus**, a smart contract-based NFT marketplace built with Solidity, Hardhat, and OpenZeppelin. This project allows users to mint, list, buy, and sell NFTs on the Ethereum Sepolia Testnet.

---

## 🚀 **Project Setup**
### **1️⃣ Prerequisites**
Ensure you have the following installed:
- [Node.js (v18+)](https://nodejs.org/)
- [Hardhat](https://hardhat.org/)
- [MetaMask](https://metamask.io/)
- [Sepolia EtherScan Account](https://sepolia.etherscan.io/)

### **2️⃣ Clone the Repository**
```sh
git clone https://github.com/riitr/nft-nexus-contracts.git
cd nft-nexus-contracts
```

### **3️⃣ Install Dependencies**
```sh
npm install
```

---

## ⚙️ **Hardhat Setup & Configuration**
### **1️⃣ Create .env File**
Create a `.env` file in the root directory and add the following:
```sh
SEPOLIA_RPC_URL="https://sepolia.infura.io/v3/YOUR_INFURA_API_KEY"
PRIVATE_KEY="YOUR_METAMASK_PRIVATE_KEY"
ETHERSCAN_API_KEY="YOUR_ETHERSCAN_API_KEY"
```
✅ Replace `YOUR_INFURA_API_KEY`, `YOUR_METAMASK_PRIVATE_KEY`, and `YOUR_ETHERSCAN_API_KEY` with actual values.

### **2️⃣ Compile Contracts**
```sh
npx hardhat compile
```

### **3️⃣ Run Tests**
```sh
npx hardhat test
```

---

## 📜 **Deploying the Smart Contract**
### **1️⃣ Deploy to Sepolia Testnet**
```sh
npx hardhat run scripts/deploy.js --network sepolia
```

### **2️⃣ Verify the Contract on Etherscan**
```sh
npx hardhat verify --network sepolia DEPLOYED_CONTRACT_ADDRESS "PAYMENT_TOKEN_ADDRESS" "FEE_RECIPIENT_ADDRESS"
```
📌 Replace `DEPLOYED_CONTRACT_ADDRESS`, `PAYMENT_TOKEN_ADDRESS`, and `FEE_RECIPIENT_ADDRESS` with actual values.

---

## 🔎 **Interacting with the Smart Contract**
### **1️⃣ Open Hardhat Console**
```sh
npx hardhat console --network sepolia
```
### **2️⃣ Mint an NFT**
```js
const NFTMarketplace = await ethers.getContractFactory("NFTMarketplace");
const marketplace = await NFTMarketplace.attach("DEPLOYED_CONTRACT_ADDRESS");
await marketplace.mintNFT("ipfs://your-nft-metadata", 500);
```

---

## 📂 **Project Structure**
```
📦 nft-nexus-contracts
 ┣ 📂 contracts           # Solidity smart contracts
 ┃ ┣ 📜 index.sol # Main marketplace contract
 ┣ 📂 scripts             # Deployment & interaction scripts
 ┃ ┣ 📜 deploy.js         # Deploy contract
 ┣ 📜 hardhat.config.js   # Hardhat configuration
 ┣ 📜 package.json        # Dependencies
 ┣ 📜 README.md           # Project documentation
 ┗ 📜 .env                # Environment variables
```

---

## 🎯 **Next Steps**
- ✅ Integrate the contract with a **React Frontend**
- ✅ Improve UI/UX with **Tailwind CSS**
- ✅ Deploy on **Polygon or Ethereum Mainnet**

### 🌟 **Happy Building!** 🚀

