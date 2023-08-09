// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract LOL is ERC20 {
    constructor() ERC20("LOL", "LOL") {
        _mint(msg.sender, 100000);
    }
}

contract MarketPlace {
    address public owner;
    mapping(uint256 => uint256) public prices;
    mapping(uint256 => address) public holder;
    LOL lol;

    constructor(address a_){
        owner = msg.sender;
        lol = LOL(a_);
    }

    function buy(uint256 id) external {
        lol.transferFrom(msg.sender, owner, prices[id]);
        holder[id] = msg.sender;
    }

    function changeprice(uint256 id, uint256 new_price) external {
        prices[id] = new_price;
    }
}