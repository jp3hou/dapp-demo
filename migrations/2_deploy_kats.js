var KatCoin = artifacts.require("./KatCoin.sol");

module.exports = function(deployer) {
  deployer.deploy(KatCoin);
};
