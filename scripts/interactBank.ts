import { ethers } from "hardhat";

async function main() {
    const tokenAddress = "0xE1d66BD37B345A7EFfF21dd2a71014Ae57477c88"

    const bankAddress = "0xA03ade3f4683a2f88a2A423C42b280C6b3e3B7F1"

    const cooperateBank = await ethers.getContractAt("IBank", bankAddress);

    const token = await ethers.getContractAt("IToken", tokenAddress);

    (await token.approve(bankAddress, 10000)).wait();

    const txDeposit = await cooperateBank.deposit(3000)
    await txDeposit.wait(); 
  
    console.log(txDeposit)
  
  
}
//0xA03ade3f4683a2f88a2A423C42b280C6b3e3B7F1

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});


//0xe60490b57c65175aD2690F091538f04360951C5F
//0xCb7F9dA240baB13085D5B59CeE033E60BE1fd813
//0x8F8Bdd40D715Fd7E5d2869132f298e3ba660E9AF
//0x3Ac162C5a266D8B2D2B51C80eC216b6A53103161
//0xcf4dd44F8DF24B9468a047d0CbD3cbC77F0ad3D5
