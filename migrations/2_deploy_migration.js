const ZombieFactory = artifacts.require("ZombieFactory");
module.exports = function(deployer, network, accounts) {
  var defaultAccount;
    if (network == "ganache") {
        defaultAccount = accounts[0]
    } else {
        defaultAccount = accounts[1]
    }
  deployer.deploy(ZombieFactory, "", defaultAccount);
};