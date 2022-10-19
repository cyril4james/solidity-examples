# Hello.sol code:

pragma solidity ^0.4.19;
contract Hello {
    // internal state variable used to store the current name
    string name;

    // Constructor
    function Hello(string initialName) public {
        name = initialName;
    } // Hello

    // Function to say hello to the current name
    function sayHello() constant public returns (string, string) {
        return ("Hello", name);
    } // sayHello

    // Function to set or change the value of the name
    function setName(string x) public {
        name = x;
    } // setName
} // Hello