// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IToken {
    // Functions have to be overrided.
    function transferFrom(address from, address to, uint256 amount) external;
    function transfer(address to, uint256 amount) external;
    function balanceOf(address user) external view returns(uint256);

    // We don't have to override Events.
    event Transfer(address indexed from, address indexed to, uint256 amount);
} 