// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract AutomobileTracking {
    address public owner;
    
    struct Automobile{
    string make;
    string model;
    uint _year;
    address _owner;
    }

    mapping(uint=>Automobile) public automobile;

    mapping(string=>uint) public totalAutomobiles;

    modifier onlyOwner() {
        require(owner==msg.sender, "only Owner has access");
        _;
    }
    constructor(){
         owner=msg.sender;
    }

    function addAutomobile(string memory _make, string memory _model, uint year) public onlyOwner {
        uint id = totalAutomobiles[_model]++;
        automobile[id] = Automobile(_make, _model, year, msg.sender);



    }

    function transferAutomobile(uint _id, address _newOwner) public onlyOwner {
        Automobile storage _automobile = automobile[_id];
        require(msg.sender==_automobile._owner, "You are not the owner of this automobile");
        require(_newOwner != address(0), "Invalid new owner address");
        _automobile._owner=_newOwner;

    }

    function getAutomobileCount(string memory model) public view returns(uint) {
        return totalAutomobiles[model];
    }

}

