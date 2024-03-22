import { HardhatUserConfig } from "hardhat/config";
import { config as dotenvConfig } from "dotenv";
import "@nomicfoundation/hardhat-toolbox";
import { resolve } from "path";

dotenvConfig({ path: resolve(__dirname, "./.env") });

const config: HardhatUserConfig = {
  solidity: {
    version: "0.8.20",
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
    musterMainnet: {
      url: process.env.MUSTER_URL || 'https://muster.alt.technology',
      accounts: [process.env.PRIVATE_KEY || ''],
    },
    opDemo: {
      url: process.env.OPDEMO_URL || 'https://op-demo.alt.technology',
      accounts: [process.env.PRIVATE_KEY || ''],
    },
    form: {
      url: process.env.OPDEMO_URL || 'https://form-testnet.alt.technology',
      accounts: [process.env.PRIVATE_KEY || ''],
    }
  },
  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://etherscan.io/
    apiKey: {
      pop: "abc",
      muster: 'abc',
      musterMainnet: 'abc',
      opDemo: 'abc',
      form: 'abc'
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
      {
        network: 'musterMainnet',
        chainId: 4078,
        urls: {
          apiURL: 'https://muster-explorer.alt.technology/api',
          browserURL: 'https://muster-explorer.alt.technology',
        },
      },
      {
        network: 'opDemo',
        chainId: 20240219,
        urls: {
          apiURL: 'https://op-demo-explorer.alt.technology/api',
          browserURL: 'https://op-demo-explorer.alt.technology',
        }
      },
      {
        network: 'form',
        chainId: 27182,
        urls: {
          apiURL: 'https://form-testnet-explorer.alt.technology/api',
          browserURL: 'https://form-testnet-explorer.alt.technology',
        }
      }
    ]
  }
};

export default config;
