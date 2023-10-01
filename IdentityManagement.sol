// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IdentityManagement {

    address public owner;
    struct Identity {
        string name;
        uint age;
        string publicKey;
        address IdentityHolder;
    }


    mapping(address => Identity) public identities;
    

    modifier onlyOwner(){
        require(owner==msg.sender, "only Owner has access");
        _;
    }

    constructor(address _owner) {
        owner=_owner;
    }

    event IdentityCreated(address indexed owner, string name, uint age);

    function _createIdentity(string memory _name, uint _age, string memory _publicKey) public onlyOwner{
        require(bytes(_name).length>0, "Name can not be empty");
        require(_age>0, "Age must be greater than zero");
        require(bytes(_publicKey).length>0, "public key should not be empty");
        require(identities[msg.sender].IdentityHolder==address(0), "Identity already exists");
        Identity storage newIdentity = identities[msg.sender];
        newIdentity.name= _name;
        newIdentity.age= _age;
          newIdentity.publicKey= _publicKey;
          newIdentity.IdentityHolder=msg.sender;
          emit IdentityCreated(msg.sender, _name, _age);






    }

    function updateIdentity(string memory _name, uint _age, string memory _publicKey) public onlyOwner{
         require(bytes(_name).length>0, "Name can not be empty");
        require(_age>0, "Age must be greater than zero");
        require(bytes(_publicKey).length>0, "public key should not be empty");
        require(identities[msg.sender].IdentityHolder !=address(0), "Identity can not be empty");
        Identity storage _updateIdentity = identities[msg.sender];
        _updateIdentity.name= _name;
        _updateIdentity.age= _age;
          _updateIdentity.publicKey= _publicKey;
          _updateIdentity.IdentityHolder=msg.sender;
    }

    function revokeIdentity() public onlyOwner{
        require(identities[msg.sender].IdentityHolder != address(0), "address must not be zero");
         delete identities[msg.sender];
    }


}
