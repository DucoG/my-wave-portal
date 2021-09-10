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


    //get userdata from address
    //mapping(address => User) users;


    constructor() {
        console.log("Hello, this is a smart contract");
        waveCounter = 0;
    }

    function checkIfRegistered() external view returns(bool){
        return getIdFromAddress[msg.sender] > 0;
    }

    //register
    function register(string calldata _username) external {
        require(getIdFromAddress[msg.sender] < 1, "You already picked a username! You can delete your account by using the 'deleteAccount' function." );
        require(getIdFromUsername[_username] < 1, "This username already exists :(");
        require(bytes(_username).length > 1, "Your username should be longer than one character");
        //registration process
        getIdFromAddress[msg.sender] = users.length + 1;
        getIdFromUsername[_username] = users.length + 1;
        users.push(User(_username, msg.sender, 10, 0, 0, users.length + 1));
        usernames.push(_username);
        console.log("Hi %s, you now picked a username and have received 10 wavebucks for it!", _username);
    }

    //delete account


    //Temporary!!!
    //get user data
    function getUserData() public view returns (User memory) {
        require(getIdFromAddress[msg.sender] > 0, "You must have picked a username to read user data");
        uint id = getIdFromAddress[msg.sender];
        return users[id-1];
    }

    // wave with message and money
    function wave(string calldata _receiverUsername , string calldata _message, uint _sentBucks) external {
        require(getIdFromAddress[msg.sender] > 0, "Please pick a username before waving in order to receive your free wavebucks :)");
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
        users[senderId - 1].wavebuckBalance -= _sentBucks;
        users[senderId - 1].wavebuckBalance += 1;

        
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

