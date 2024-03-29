// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Buraya kadar contract'ları hep Remix UI ile ağa deploy ediyorduk.
// Bir Blockchain node'larla konuşup bu kontratı duyurucaz.
// Başka bir kontrat deploy etme yöntemi de başka bir kontrat ile deploy etmek.
// Bu yapılara genelde 'FACTORY CONTRACT' denir.

// It is a FACTORY CONTRACT 
contract VaultFactory {
    mapping(address => Vault[]) public userVaults;      // Kullanıcı kasalarım

    // Classic creating
    function createVault() external {
        Vault vault = new Vault(msg.sender);   
        userVaults[msg.sender].push(vault);   
    }

    // Miktar 0 iken kontrol yapmadığımız için üstteki fonksiyona aslında gerek yok. Miktar 0 olunca da bu çalışabilir yine.
    // Funded Creating
    function createVaultWithPayment() external payable {
        Vault vault = (new Vault){value: msg.value}(msg.sender);
        userVaults[msg.sender].push(vault);
    }
}


contract Vault {
    address public owner;
    uint256 private balance;

    constructor(address _owner) payable {
        owner = _owner;
        balance += msg.value;
    }

    // Hata olduğu zaman atılmaya çalışılan miktar 'Göndericiye: msg.sender' a geri dönsün.
    fallback() external payable {
        balance += msg.value;
    }
    receive() external payable {
        balance += msg.value;
    }

    function getBalance() external view returns (uint256) {
        return balance;
    }

    // Contract'a Ether yatır
    function deposit() external payable {
        balance += msg.value;
    }
    // Contract'tan Ether çek.
    function withdraw(uint256 _amount) external {
        require(msg.sender == owner, "You are not authorized.");    //Başka biri etki etmesin diye.
        balance -= _amount;
        payable(owner).transfer(_amount);
    }
}

// HOW TO USE  (TR): Nasıl Kullanıcaz? 
// 1-Compile the code.
// 2-Deploy VaultFactory
// 3-Create a vault by using createVault function.
// 4-Take an address above Remix IDE provides us. And, put as parameter that address to userVaults array. It outputs an address.
// 5-Choose Vault as contract, At Address block: Use this address.      --->  Contract is deployed.