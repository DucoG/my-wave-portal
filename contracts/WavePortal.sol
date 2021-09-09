// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {

    //save the waves
    struct Wave {
        string message;
        string waver;
        string wavee;
        uint timestamp;
        uint bucksAttached;
    }
    //save incomming and outgoing waves
    mapping(uint => Wave[]) incommingWaves;
    mapping(uint => Wave[]) outgoigWaves;

    //Wave[] waves;
    uint waveCounter;

    //save users
    struct User {
        string username;
        address addr;
        uint wavebuckBalance;
        uint totalWaved;
        uint lastWave;
        uint id;
    }
    //save users
    User[] users;


    //check if user exists
    mapping(address => uint) getIdFromAddress;

    //username for displaying address book
    string[] usernames;

    //get id from username
    mapping(string => uint) getIdFromUsername;

    //return userdata

    //get userdata from address
    //mapping(address => User) users;


    constructor() {
        console.log("Hello, this is a smart contract");
        waveCounter = 0;
    }

    //register
    function register(string memory _username) public{
        require(getIdFromAddress[msg.sender] < 1, "You're already registered! You can delete your account by using the 'deleteAccount' function." );
        //registration process
        getIdFromAddress[msg.sender] = users.length + 1;
        getIdFromUsername[_username] = users.length + 1;
        users.push(User(_username, msg.sender, 10, 0, 0, users.length + 1));
        usernames.push(_username);
        console.log("Hi %s, you are now a registered user and have received 10 wavebucks for free!", _username);
    }

    //delete account


    //Temporary!!!
    //get user data
    function getAllUserData() public view returns (User[] memory) {
        require(getIdFromAddress[msg.sender] > 0, "You must be registered in order to read user data");
        return users;
    }

    // wave with message and money
    function wave(string memory _receiverUsername , string memory _message, uint _sentBucks) public {
        require(getIdFromAddress[msg.sender] > 0, "Please register before waving in order to receive your free wavebucks :)");
        require(getIdFromUsername[_receiverUsername] > 0, "that username isn't registered!");


        //make variables
        string memory senderName = users[getIdFromAddress[msg.sender] - 1].username;
        uint senderId = getIdFromAddress[msg.sender];
        uint receiverId = getIdFromUsername[_receiverUsername];

        require(_sentBucks <= users[senderId].wavebuckBalance, "You dont have enough money!");


        waveCounter += 1;

        //save wave as incoming and outgoing
        incommingWaves[receiverId].push(Wave(_message, senderName, _receiverUsername, block.timestamp, _sentBucks));
        outgoigWaves[senderId].push(Wave(_message, senderName, _receiverUsername, block.timestamp, _sentBucks));
        users[receiverId - 1].wavebuckBalance += _sentBucks;
        users[senderId - 1].wavebuckBalance -= _sentBucks - 1;

        
        console.log("You just waved at %s with for with the following message:", _receiverUsername);
        console.log(_message);
        console.log("You attached %s WaveBucks to your wave", _sentBucks);
        console.log("You received %s WaveBucks for your wave!", 1);


        //waves.push(Wave(_message, msg.sender, block.timestamp, _sentBucks));
        //emit NewWave(msg.sender, block.timestamp, _message);
    }

    function getIncommingWaves() public view returns(Wave[] memory){
        uint senderId = getIdFromAddress[msg.sender];
        return incommingWaves[senderId];
    }

    function getOutgoingWaves() public view returns(Wave[] memory){
        uint senderId = getIdFromAddress[msg.sender];
        return outgoigWaves[senderId];
    }

    // function getAllWaves() view public returns(Wave[] memory) {
    //     return waves;
    // }

    function getWaveCounter() public view returns (uint) {
        console.log("Our wavecounter is at %d", waveCounter);
        return waveCounter;
    }


}

