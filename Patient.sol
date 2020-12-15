// SPDX-License-Identifier: GPL-3.0 

pragma solidity ^0.7.0;
 
/** @title PatientRecord */
contract PatientRecord {
    
    // ** Part 1 ** Enums **
    enum Gender { Male, Female }    
    
    // ** Part 2 ** Structs **
    struct Patient {
        string name; 
        uint age;
        Gender gender;
    }
         
    // ** Part 3 ** State Variables **
    uint id; //Id for the patient record
    Patient private patient; // The patient we are referring to
    address public recordOwner; //The address of the owner
    mapping(address => bool) public doctors; //Mapping of doctors for access to record

    // ** Part 4 ** Modifiers **
    // Like a protocol that a function should follow
    modifier onlyOwner() {
        require(
            msg.sender == recordOwner,
            "You are not the owner of this record!"
        );
        _;
    }

    modifier onlyAccessors() {
        require(
            msg.sender == recordOwner || doctors[msg.sender] == true,
            "You are not the owner of this record nor a doctor of the patient!"
        );
        _;
    }
    // ** Part 6 ** Functions **
    constructor() {
        recordOwner = msg.sender;
    }
    
    function getPatientName() public view onlyAccessors returns (string memory) {
        return patient.name;
    }
      
    // Note that the function has the onlyOwner Modifier
    function setPatientName(string memory name) public onlyOwner {
        patient.name = name;
    }
    
    function addDoctor(address doctor) public onlyOwner {
        doctors[doctor] = true;
    }
    
}