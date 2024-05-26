import * as dotenv from "dotenv";
import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

dotenv.config();

const {
  DEFAULT_DEPLOY_NETWORK,
  DEPLOY_KEY,
  SEPOLIA_API_URL,

} = process.env;

// @ts-ignore
const config: HardhatUserConfig = {
  solidity: {
    compilers: [
      {
        version: "0.8.24",
        settings: {
          optimizer: {
            enabled: true,
            runs: 100,
          },
        },
      },
    ],
  },
  defaultNetwork: DEFAULT_DEPLOY_NETWORK || "localhost",
  networks: {
    hardhat: {
      loggingEnabled: true,
      mining: {
        auto: true,
      },
      // accounts: PRIVATE_KEY ? [`0x${PRIVATE_KEY}`] : [],
    },
    sepolia: {
      loggingEnabled: true,
      url: SEPOLIA_API_URL || "",
      accounts: DEPLOY_KEY
      ? [`0x${DEPLOY_KEY}`]
      : [],

    }
  },
};

export default config;
