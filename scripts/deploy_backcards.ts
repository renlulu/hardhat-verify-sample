import { ethers } from "hardhat";

async function main() {
  const backcards = await ethers.deployContract("CosmikBattleBackCards", ['0xD35B4A65402d3BE4793CB06169D13f0DdbaF3AAf']);
  await backcards.waitForDeployment();
  console.log("deployed address: ", await backcards.getAddress())
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
