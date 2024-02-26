import { ethers } from "hardhat";

async function main() {
  
  const token = await ethers.deployContract("Token");

  await token.waitForDeployment();

  console.log(
    `Token deployed to ${token.target}`
  );

  // const [add1, add2, add3, add4, add5] = await ethers.getSigners();

  // const addresses = [add1.address, add2.address, add3.address, add4.address, add5.address]
  
  const cooperateBankFactory = await ethers.deployContract("MultiSigFactory");
await cooperateBankFactory.waitForDeployment();

console.log(`MultiSigFactory deployed to ${cooperateBankFactory.target}`);
}



// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
