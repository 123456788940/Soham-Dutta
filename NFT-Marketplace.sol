// SPDX-License-Identifier: MIT
pragma solidity ^0.8; // or a similar version


import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract convertTokenContract {
    address public owner;
    IERC20 public ethToken;

    constructor(address _ethToken){
        owner=msg.sender;
        ethToken=IERC20(_ethToken);
    }

        mapping(address=>uint) public balances;

        function depositTokens(uint amount) external {
            require(amount>0, "amount must be greater than zero");
            require(ethToken.transferFrom(msg.sender, address(this), amount), "Token transfer failed");
            balances[msg.sender] += amount;

        }

        function withdrawTokens(uint amount) external {
            require(amount>0, "amount must be greater than zero");
            require(balances[msg.sender]>=amount, "amount has to be appropriate");
            balances[msg.sender]-=amount;
            require(ethToken.transfer(msg.sender, amount), "everything has to be appropriate");
        }
    
}
