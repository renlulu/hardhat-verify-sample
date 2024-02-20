import { HardhatUserConfig } from "hardhat/config";
import { config as dotenvConfig } from "dotenv";
import "@nomicfoundation/hardhat-toolbox";
import { resolve } from "path";

dotenvConfig({ path: resolve(__dirname, "./.env") });

const config: HardhatUserConfig = {
  solidity: {
    version: "0.8.19",
    settings: {
      optimizer: {
        enabled: true,
        runs: 1000,
      },
    },
  },
  networks: {
    muster: {
      url: process.env.MUSTER_URL || 'https://muster-anytrust.alt.technology',
      accounts: [process.env.PRIVATE_KEY || ''],
    },
  },
  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://etherscan.io/
    apiKey: {
      pop: "abc",
      muster: 'abc',
    },
    customChains: [
      {
        network: 'muster',
        chainId: 2121337,
        urls: {
          apiURL: 'https://muster-anytrust-explorer-v2.alt.technology/api',
          browserURL: 'https://muster-anytrust-explorer-v2.alt.technology',
        },
      },
    ]
  }
};

export default config;
