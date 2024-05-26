import * as dotenv from 'dotenv';
import '@nomicfoundation/hardhat-toolbox';
import config from './hardhat.config';

dotenv.config();

config['typechain'] = {
     outDir: '../packages/smart-contracts',
     target: 'ethers-v5'
};

export default config;
