// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FirstTouch{
    // State Variables are variables whose values are permanently stored in contract storage.
    string public sayHello = "Hello World!";
    
    //  Functions
    // Pure: a function (a block of code) that always returns the same result if the same arguments are passed.
    function show() public pure returns(string memory){
        // Local Variables
        string memory localString = "My Local String";
        return localString;
    }

    // View: a function that only reads but doesn't alter the state variables defined in the contract is called a View Function
    function showBlockNumber() public view returns(uint){
        // Global Variables
        return block.number;
    }
    uint x = 3;
    function add(uint y) public view returns(uint){
        return x+y;
    }
    // Public: We can call it everywhere.
    function publicKeyword() public pure returns(string memory) {
        return "Public Function";
    }
    function callPublicKeyword() public pure returns(string memory) {
        return publicKeyword();
    }

    // Private: Inside contract, we can call it.
    function privateKeyword() private pure returns(string memory) {
        return "Private function";
    }
    function callPrivateKeyword() public pure returns(string memory) {
        return privateKeyword();
    }

    // Internal: Only who inherited can call it.
    function internalKeyword() internal pure returns(string memory) {
        return "Internal Function";
    }
    function callInternalKeyword() public pure returns(string memory) {
        return internalKeyword();
    }

    // External : We can not call inside the contract.

    // function externalKeyword() external pure returns(string memory) {
    //     return "bu bir external fonskiyondur...";
    // }


}