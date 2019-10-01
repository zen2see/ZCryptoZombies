pragma solidity >=0.5.0;

import "./ZombieFactory.sol";

contract ZombieFeeding is ZombieFactory {

    function feedAndMultiply(uint _zombieId, uint _targetDna) public {
        require(
          msg.sender == zombieToOwner[_zombieId],
          "we must be the owner"
        );
        Zombie storage myZombie = zombies[_zombieId];
    }
}