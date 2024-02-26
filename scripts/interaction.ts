import { ethers } from "hardhat";

async function main() {

    const tokenAddress = "0x8D332F125EA507D0CedCaB549b6836e3116f196a"
    const factoryAddress = "0xC52e826804A1faB1702146d4e9746ecA2408B5Ce"

    const bankingFactory = await ethers.getContractAt("IFactory", factoryAddress);

    const addresses = ["0x5b338a22Edef630d29e4B3728293bbfE9A25B6BA", "0x6d2FfC7Bc54e1A420F6a2809721A1D25B415c003"];

  const tx = await bankingFactory.createMultiCooperateBank(tokenAddress, addresses, 2);
  await tx.wait();

  const result = await bankingFactory.getMultiCooperateBank();
  console.log(result);

 
  
}



// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});





//Token address "0x8D332F125EA507D0CedCaB549b6836e3116f196a"
//factory address "0xC52e826804A1faB1702146d4e9746ecA2408B5Ce"
//Result "0xe60490b57c65175aD2690F091538f04360951C5F"