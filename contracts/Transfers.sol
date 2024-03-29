// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bank{
    
    mapping(address => uint) balances;

    // The function has to payable to send ethers, if not error is occured.
    // If we want to ether to a function it has to be " payable ".
    function sendEthersToContract() payable external {
        balances[msg.sender] = msg.value;
    }

    function showBalance() external view returns(uint){
        return balances[msg.sender];
    } 

    // If we want to send ethers to a address. The Address is also has to be " payable ".
    function withdraw(address payable to,uint amount) external {
        require(balances[msg.sender] >= amount, "insufficient funds");      // control if we have the amount or not
        //payable(msg.sender).transfer(balances[msg.sender]);  //Parameter is already payable. it is not necessary anymore.
        to.transfer(amount);
        balances[msg.sender] -= amount;        // update the balance
    }
    //1- Transfer() ---------------------------------
    // If the address does not have the amount that it want to send. The amount will be revert to the address.  It is the feature of transfer() function.


    // 2- Send()
    // It returns the status of the process:        true-false
    function withdrawSend(address payable to,uint amount) external returns(bool){
        bool status = to.send(amount);
        balances[msg.sender] -= amount;        // update the balance
        return status;
    }

    // 3- Call()
    function withdrawCall(address payable to,uint amount) external returns(bool){
        (bool status,) = to.call{value: amount}("");        // bool status, ==> even if the second parameters is null I have to be write it.
        balances[msg.sender] -= amount;        // update the balance
        return status;
    }

    //** receive() ==>  If ether is sent to contract, what the contract should do?
    uint public receiveCount = 0;
    receive() external payable {
        receiveCount++;
     }

    // fallback()  ==>  It provides to communicate to send data to the contract.
    // If you don't have receive function, so even if there is no data in transaction the fallback function will be called.
    uint public fallbackCount = 0;
    fallback() external payable { 
        fallbackCount++;
    }


}