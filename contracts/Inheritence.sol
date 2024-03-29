// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


// virtual
contract A {
    uint public x;

    uint public y;

    // if we want to override a method      we have to use " virtual " modifier.
    function setX(uint _x) virtual public {
        x = _x;
    }

    function setY(uint _y) public {
        y = _y;
    }
}

// by using ' is '  B inherits A
contract B is A {

    uint public z;
    function setZ(uint _z) public {
        z = _z;
    }

    // and exactly the " override " modifier.
    function setX(uint _x) override public {
        x = _x + 2;
    }

}

contract Human {
    function sayHello() public pure virtual returns(string memory) {
        return "itublockchain.com adresi uzerinden kulube uye olabilirsiniz :)";
    }
}

contract SuperHuman is Human {
    function sayHello() public pure override returns(string memory) {
        return "Selamlar itu blockchain uyesi, nasilsin ? :)";
    }

    function welcomeMsg(bool isMember) public pure returns(string memory) {
        return isMember ? sayHello() : super.sayHello();
    }
}