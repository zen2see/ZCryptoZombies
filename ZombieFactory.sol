pragma solidity >=0.5.0;

contract ZombieFactory {

    event NewZombie(uint zombieID, string zombieName, uint zombieDna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

    function _createZombie(string _name, uint _dna) private {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender]++;
        emit NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodedPacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string _name) public {
        require(
          ownerZombieCount[msg.sender] == 0,
          "execution only once per user"
        );
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}