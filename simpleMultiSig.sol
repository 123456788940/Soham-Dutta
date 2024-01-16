
// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract multiSig is ERC20 {
    address public owner;

    constructor() ERC20("Shiva", "Sh") {
        owner = msg.sender;
    }

    struct wallet {
     
        bool sent;
        bool received;
    }
    mapping(address=>wallet) public Wallet;

address[] public owners = [0x5B38Da6a701c568545dCfcB03FcB875f56beddC4, 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB];

    function send(address to, uint amount, address[] memory _owners) external payable{
        _owners = owners;
        require(_owners.length ==2, "not the sufficient number of owners");
        for (uint i = 0; i < _owners.length; i++) {
           require(Wallet[_owners[i]].sent, "amount not sent");
           Wallet[_owners[i]].sent = true;
           _burn(to, amount);
        }
    }


    function _receive(uint amount, address[] memory _owners) external {
        _owners = owners;

          require(_owners.length ==2, "not the sufficient number of owners");
          for (uint i = 0; i < _owners.length; i++) {
           require(Wallet[_owners[i]].received, "amount not sent");
           Wallet[_owners[i]].received = true;
           _mint(owner, amount);
        }
    }

    
}
