pragma solidity >=0.5.0;

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {

  uint levelUpFee = 0.001 ether;

  modifier abovelevel(uint _level, uint _zombieId) {
      require(
        zombies[_zombieId].level >= _level,
        "zombie should reach a certain level"
      );
      _;
  }

  function withdraw()
      external
      onlyOwner
  {
      address _owner = owner();
      // uint amount = address(this).balance;
      // zero the pending amount before sending to prevent re-entrancy
      // address(this).balance = 0;
      address(uint160(_owner)).transfer(address(this).balance);
  }

  function setLevelUpFee(uint _fee)
      external
      onlyOwner
  {
    levelUpFee = _fee;
  }

  function levelUp(uint _zombieId)
      external
      payable
  {
    require(
      msg.value == levelUpFee,
      "msg.value should cover cost of levelUpFee"
    );

    zombies[_zombieId].level;
  }

  function changeName(uint _zombieId, string calldata _newName)
      external
      abovelevel(2, _zombieId)
      onlyOwnerOf(_zombieId)
  {
      zombies[_zombieId].name = _newName;
  }

  function changeDna(uint _zombieId, uint _newDna)
      external
      abovelevel(20, _zombieId)
      onlyOwnerOf(_zombieId)
  {
      zombies[_zombieId].dna = _newDna;
  }

  function getZombiesByOwner(address _owner)
      external
      view
      returns (uint[] memory)
  {
      uint[] memory result = new uint[](ownerZombieCount[_owner]);
      uint counter = 0;
      for (uint i = 0; i < zombies.length; i++) {
        if (zombieToOwner[i] == _owner) {
          result[counter] = i;
          counter++;
        }
      }
      return result;
  }

}