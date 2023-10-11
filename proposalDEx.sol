// SPDX-License-Identifier: MIT
pragma solidity ^0.8;


contract Dex {
    address public owner;
   uint public proposalCount;
   uint public amount;

    struct endorseTransaction {
  
        bool isAccepted;
        bool endorsed;
        bool executed;
        bool withdrawn;
    }
    uint public totalBalance=1000000;

    mapping(address=>endorseTransaction) public transactions;

    constructor() {
        owner=msg.sender;
    }


    function propose(uint _amount) public {
      
        require(_amount>=100, "amount must not exceed 100");
        require(!transactions[msg.sender].isAccepted, "proposal not accepted");
         require(!transactions[msg.sender].endorsed, "proposal not endorsed");
         transactions[msg.sender]=endorseTransaction({
           isAccepted:true,
           endorsed:true,
           executed:false,
           withdrawn:false
          
         });
         amount=_amount;
         totalBalance-=_amount;



    }

    function endorseProposal() public {
        require(msg.sender==owner, "only owner has access");
          require(transactions[msg.sender].isAccepted, "proposal accepted");
                  require(transactions[msg.sender].endorsed, "proposal endorsed");
                          require(!transactions[msg.sender].executed, "proposal not executed");
                          transactions[msg.sender].executed=true;
                          proposalCount++;

    }

    function withdrawAmount() public {
        require(transactions[msg.sender].executed, "proposal not executed");
        require(!transactions[msg.sender].withdrawn, "withdraw not executed");
        transactions[msg.sender].withdrawn=true;
        totalBalance+=amount;
        transactions[msg.sender].executed=false;
        proposalCount-=1;
        
    }
}
