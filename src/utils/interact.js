import { API_URL } from "../config";

const { createAlchemyWeb3 } = require("@alch/alchemy-web3");
const contract = require("../artifacts/contracts/NftMinter.sol/NftMinter.json");

const web3 = createAlchemyWeb3(API_URL);

const contractAddress = "0x5a38bD2ff320356E47968535F3a8518ebD11aC16";

const nftContract = new web3.eth.Contract(contract.abi, contractAddress);

export const connectWallet = async () => {
  if (window.ethereum) {
    try {
      const addressArray = await window.ethereum.request({
        method: "eth_requestAccounts",
      });
      return {
        status: "",
        address: addressArray[0],
      };
    } catch (error) {
      return {
        status: error.message,
        address: "",
      };
    }
  } else {
    return {
      address: "",
      status: (
        <span>
          <p>
            <a target={"_blank"} href="https://metamask.io/download.html">
              Metamask yüklü olmayabilir! Yüklemek için tıklayınız.
            </a>
          </p>
        </span>
      ),
    };
  }
};

export const getCurrentWalletConnected = async () => {
  if (window.ethereum) {
    try {
      const addressArray = await window.ethereum.request({
        method: "eth_accounts",
      });

      if (addressArray.length > 0) {
        return {
          status: "",
          address: addressArray[0],
        };
      } else {
        return { status: "Adres Yok!", address: "" };
      }
    } catch (error) {
      return {
        status: error.message,
        address: "",
      };
    }
  } else {
    return {
      address: "",
      status: (
        <span>
          <p>
            <a target={"_blank"} href="https://metamask.io/download.html">
              Metamask yüklü olmayabilir! Yüklemek için tıklayınız.
            </a>
          </p>
        </span>
      ),
    };
  }
};

export const getMaxMintAmount = async () => {
  const maxMintAmount = await nftContract.methods.maxTokenPurchase().call();
  return maxMintAmount;
};

export const getTotalSupply = async () => {
  return await nftContract.methods.totalSupply().call();
};

export const getNftPrice = async () => {
  const tokenPriceWei = await nftContract.methods.tokenPrice().call();
  return web3.utils.fromWei(tokenPriceWei, "ether");
};
