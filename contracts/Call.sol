//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Test {
    uint256 public total = 0;
    uint256 public fallbackCalled = 0;
    string public incrementer;

    fallback() external payable {
        fallbackCalled ++;
    } 

    function increment(uint256 _amount, string memory _incrementer) external returns(uint256) {
        total += _amount;
        incrementer = _incrementer;

        return total;
    } 
}

contract Caller {
    
    function testCall(address _contract, uint256 _amount, string memory _incrementer) external returns (bool, uint256) {
        // _contract.call(abi.encodeWithSignature("inc(uint256, string)", _amount, _incrementer)); 
       (bool err, bytes memory res) = _contract.call(abi.encodeWithSignature("increment(uint256, string)", _amount, _incrementer));
        uint256 _total = abi.decode(res, (uint256));
        return (err, _total);
    }

    // Diğer Contract'ın fallback fonksiyonu varsa onu TETİKLİCEK
    function triggerFallback(address _contract) external payable {
        (bool err,) = _contract.call{value: msg.value}("");
        if(!err) revert();
    }


}