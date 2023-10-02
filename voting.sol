// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;



contract Voting{
address private owner;
address private PeopleVoters;


struct Voter{
    address voter;
    bool isRegistered;
    bool hasVoted;
    string selectedCandidate;
}
 mapping(address=>Voter) public voters;
 mapping(address=>uint) public voteCount;


 modifier onlyOwner(){
    require(owner==msg.sender, "only owner has access");
    _;
 }

 modifier onlyVoters() {
    require(PeopleVoters==msg.sender, "only voters have access");
    _;
 }

constructor(address _owner, address _peopleVoters) {
   owner=_owner;
    PeopleVoters= _peopleVoters;

}

event voterRegistered(address indexed _Voter, bool registrationExecuted);
function registerVoter(address _voter) public onlyOwner{
    require(!voters[_voter].isRegistered, "voter already registered");
    voters[_voter].isRegistered=true;
    emit voterRegistered(msg.sender, true);

}

event voted(address indexed VOTER, string _Candidate);
function castVote(string memory Candidate) public onlyVoters{
       require(voters[msg.sender].isRegistered, "voter registered");
       require(!voters[msg.sender].hasVoted, "vote caste already");
       require(bytes(Candidate).length>0, "candidate lentgth must be more than zero");

       require(keccak256(abi.encodePacked(Candidate))==keccak256(abi.encodePacked("Nisha")) ||
       keccak256(abi.encodePacked(Candidate))==keccak256(abi.encodePacked("Dua Lipa")) ||
       keccak256(abi.encodePacked(Candidate))==keccak256(abi.encodePacked("Alice")), "Invalid candidates");
       voters[msg.sender].isRegistered=true;
       voters[msg.sender].hasVoted=true;
       voters[msg.sender].selectedCandidate=Candidate;
       voteCount[msg.sender]++;

       emit voted(msg.sender, Candidate);


}

function getVotesCount(address _candidate) public view returns(uint) {
  return  voteCount[_candidate];
}

}
