//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Kod, ITU Blockchain Eğitiminden alınmıştır.

contract Interact {
    address public caller;
    mapping(address => uint256) public counts;

    // Which Contract call this function, the function will display that address, not the Interact contract one.
    // Caller deploy etmeden çalıştırdın. Hangi ACCOUNT'taysan o istek atmış olur.
    function callThis() external {
        caller = msg.sender;
        counts[msg.sender]++;
    }
}

contract Pay {
    mapping(address => uint256) public userBalances;

    /* function payEth() external payable {
        userBalances[msg.sender] += msg.value;
    } */      
    // receive,  fallback
    function payEth(address _payer) external payable {
        userBalances[_payer] += msg.value;
    }

}

// Türkçe Anlatım:
// msg.sender -> A (mesaj yollayan: msg.sender) -> B (mesaj yollayan: A adresi)
// B'ye gelen msg.sender  A'dır  baştaki msg.sender değil.
contract Caller {
    Interact interact;
    
    constructor(address _interactContract) {
        interact = Interact(_interactContract);
    }

    // Caller Contract's address will be appear.  Not the Interact Contract's address.
    // Türkçe: Çağıran adrestir yani Interact'taki oluşan adres değil.
    function callInteract() external{
        interact.callThis();
        // return address(msg.sender);      O an hangi ACCOUNT'tan deploy ettiysen o döner
    }

    // Türkçe: Interact Contract'ında callThis() çalıştığında artar.
    // Caller içindeki callInteract() çalıştığında artmaz çünkü o bizim 
    function readCaller() external view returns (address) {
        return interact.caller();
    }

    function readCallerCount() public view returns (uint256) {
        return interact.counts(msg.sender);
    }
    
    function payToPay(address _payAddress) public payable {
        Pay pay = Pay(_payAddress);
        pay.payEth{value: msg.value}(msg.sender);
        // Pay(_payAddress).payEth{value: msg.value}(msg.sender);
    }

    function sendEthByTransfer() public payable {
        payable(address(interact)).transfer(msg.value);
    }

}