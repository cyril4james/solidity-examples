// SPDX-License-Identifier: GPL-3.0 

pragma solidity ^0.7.0;

/** 
 * @title ConferenceRegistration
 * @dev Implement a simple registration contract for a conference
 */
contract ConferenceRegistration {

    address public organizer; // Address of rganizer of conference

    uint public maxParticipants; // Maximum no of participants
    uint public noRegistrations; // Current number of registrations
    uint public registrationPrice; // Price of registration
    
    enum STATUS { PAID, REFUNDED } // Status of registration
    
    // Store registrant details
    struct Registrant {
        STATUS status;
        uint payment;
    }
    
    // Mapping of registrant address and details
    mapping(address => Registrant) public registrations; 

    /*
     * Check if transaction sender is the organizer
     */
    modifier onlyOrganizer() {
        require(
            msg.sender == organizer,
            "You have no access!"
        );
        _;
    }

    /*
     * Check if maximum number of registrations is already reached
     */
    modifier maxReached() {
        require(
            noRegistrations < maxParticipants,
            "Max number of registrations reached!"
        );
        _;
    }
    
    /*
     * Check if transaction sender is already registered
     */
    modifier registered() {
        require(
            registrations[msg.sender].status == STATUS.PAID 
                && registrations[msg.sender].payment == registrationPrice,
            "You are not yet registered!"
        );
        _;
    }

    /*
     * Constructor function
     * @param _maxParticipants Maximum number of participants for this conference
     * @param _regPrice Registration price set by the organizer
     */
    constructor(uint _maxParticipants, uint _regPrice) {
        organizer = msg.sender;
        maxParticipants = _maxParticipants;
        registrationPrice = _regPrice * 1 ether;
    }
    
    /*
     * Register for the conference
     */
    function register() external payable maxReached {
        if(msg.value < registrationPrice) {
            revert('Payment is not enough!');
        }
        registrations[msg.sender].status = STATUS.PAID;
        registrations[msg.sender].payment = msg.value;
        noRegistrations++;
    }
    
    /*
     * Refund your payment
     */
    function refund() external registered {
        registrations[msg.sender].status = STATUS.REFUNDED;
        registrations[msg.sender].payment = 0;
        noRegistrations--;
        
        address payable recipient = msg.sender;
        recipient.transfer(registrationPrice);
    }
    
    /*
     * Get the total collection from registrations
     */
    function getCollection() public view onlyOrganizer returns(uint) {
        return address(this).balance;
    }

}