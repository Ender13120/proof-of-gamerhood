import { ethers } from "hardhat";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { Ancillary, Seat, Segment } from "../typechain-types";
import { Signer } from "ethers";

// NB: This script deploys a new contract and also a new proxy, so the storage will be reset.

async function main() {
  const signers = await ethers.getSigners();
  const signer = signers[signers.length - 1];

  // DEPLOY Proof of Gamer hood

  const GamerHoodFatcory = await ethers.getContractFactory(
    "GamerhoodBadge",
    signer
  );
  const gamerHoodContract = await GamerHoodFatcory.deploy();
  await gamerHoodContract.deployed();
  console.log(`gamerHoodContract deployed to ${gamerHoodContract.address}`);

  
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
