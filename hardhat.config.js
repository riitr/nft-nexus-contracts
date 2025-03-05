require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

module.exports = {
  solidity: "0.8.20",
  networks: {
    sepolia: {
      url: process.env.SEPOLIA_RPC_URL,  // Uses RPC URL from .env
      accounts: [process.env.PRIVATE_KEY]
    }
  },
  etherscan: {
    apiKey: {
      sepolia: process.env.ETHERSCAN_API_KEY  // ✅ Add this for verification
    }
  },
  sourcify: {
    enabled: true  // ✅ Enables Sourcify verification
  }
};
