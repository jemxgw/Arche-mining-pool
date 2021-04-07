require("@nomiclabs/hardhat-waffle");

// Go to https://www.alchemyapi.io, sign up, create
// a new App in its dashboard, and replace "KEY" with its key
//const ALCHEMY_API_KEY = "";

// Replace this private key with your Ropsten account private key
// To export your private key from Metamask, open Metamask and
// go to Account Details > Export Private Key
// Be aware of NEVER putting real Ether into testing accounts
const PRIVATE_KEY = "No peeking! :(";

module.exports = {
  solidity: "0.8.3",
  networks: {
    ropsten: {
      url: `https://ropsten.infura.io/v3/b59397a69a0f4639b4c70e9786a9db1f`,
      accounts: [`0x${PRIVATE_KEY}`]
    },
    hecotest: {
      url: `https://http-testnet.hecochain.com/`,
      accounts: [`0x${PRIVATE_KEY}`]
    },
  }
};
