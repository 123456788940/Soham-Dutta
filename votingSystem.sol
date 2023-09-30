// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract votingSystem {
   
   
    address private owner;
    address private _voters;
    
   


    struct votingMachine {
     
        
    

 
    string selectedCandidate;
 
      
       bool isRegistered; 
     
        bool hasVoted;
        
    }

    mapping(address=>votingMachine) public voters;
    mapping(address=>uint) public voteCount;


    modifier onlyOwner() {
        require(owner==msg.sender, "only Owner has access");
        _;
    }

    modifier onlyVoters() {
        require(_voters==msg.sender, "only voters can call the function");
        _;
    }

    constructor(address _owner) {
        owner=_owner;
      
    }


    function regVoter(address _voter) public onlyOwner {
        require(owner==msg.sender, "only the owner has access");
        require(!voters[_voter].isRegistered, "voter is already registered");
        voters[_voter].isRegistered=true;
    }


     function castVote(string memory candidate) public onlyVoters{
        require(voters[msg.sender].isRegistered, "voter is registered");
        require(!voters[msg.sender].hasVoted, "voter has always voted");
        require(bytes(candidate).length>0, "candidate name can not be empty");

        require(keccak256(abi.encodePacked(candidate))==keccak256(abi.encodePacked("Nisha")) ||
        keccak256(abi.encodePacked(candidate))==keccak256(abi.encodePacked("Melissa")) ||
        keccak256(abi.encodePacked(candidate))==keccak256(abi.encodePacked("Elssi")), "Invalid candidate"
        );
        voteCount[msg.sender]++;
        voters[msg.sender].hasVoted=true;
        voters[msg.sender].selectedCandidate=candidate;


     }

     function getVoteCount(address _candidate) public view returns (uint) {
        return voteCount[_candidate];
     }


}
