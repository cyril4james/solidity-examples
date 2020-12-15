// SPDX-License-Identifier: GPL-3.0 

pragma solidity ^0.7.0;

/** 
 * @title HelloWorld
 * @dev Implement a contract that stores and outputs a hello message.
 */
contract HelloWorld {
    string welcomeMessage;

    // Set the hello message
    function setHelloMessage(string memory message) public {
        welcomeMessage = message;
    }

    // Return the hello message
    function sayHello() public view returns (string memory) {
        return welcomeMessage;
    }
}