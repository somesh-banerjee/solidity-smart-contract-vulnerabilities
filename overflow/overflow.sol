// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

contract Overflow {
    uint8 public val;
    
    function add(uint8 value) external {
        // require(val + value <= 255, "Overflow");
        val += value; // possible overflow
    } 
}