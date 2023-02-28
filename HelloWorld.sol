// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract Hello {

    string name;
    
    constructor(string memory initialName) {
        name = initialName;
    }
    
    function sayHello() external view returns (string memory) {
        return string(abi.encodePacked("Hello, ", name));
    }
    
    function setName(string memory newName) public {
        name = newName;
    }
}
