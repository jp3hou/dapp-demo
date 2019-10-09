var Ownable = artifacts.require("./Ownable.sol");
var KatCoin = artifacts.require("./KatCoin.sol");

module.exports = function(deployer) {
  deployer.deploy(Ownable);
  deployer.deploy(KatCoin);
};
