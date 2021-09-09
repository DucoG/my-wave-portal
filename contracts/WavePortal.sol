// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {

    //event NewWave(address indexed from, uint timestamp, string message);
    uint private seed;

    struct Wave {
        string message;
        address waver;
        uint timestamp;
    }

    Wave[] waves;

    uint waveCounter;
    mapping(address => uint) public wavesPerPerson;
    mapping(address => uint) public lastWavedAt;

    constructor() payable {
        console.log("Hello, this is a smart contract");
        waveCounter = 0;
    }

    // wave with text
    function wave(string memory _message) public {
        require(lastWavedAt[msg.sender] + 30 seconds < block.timestamp, "wait 15 min");

        lastWavedAt[msg.sender] = block.timestamp;

        waveCounter += 1;
        wavesPerPerson[msg.sender] += 1;
        console.log(msg.sender, " just waved at you for the ", wavesPerPerson[msg.sender], "th time, with the following message:");
        console.log("Got message: %s", _message);
        waves.push(Wave(_message, msg.sender, block.timestamp));
        //emit NewWave(msg.sender, block.timestamp, _message);

        uint randomNumber = (block.difficulty + block.timestamp + seed) % 100;
        console.log("Random nummber =",randomNumber);
        seed = randomNumber;


        if(randomNumber < 50) {
            console.log(msg.sender, "Won!");
            uint prizeAmount = 0.0001 ether;
            require(prizeAmount <= address(this).balance, "Contract out of money!");
            (bool success,) = (msg.sender).call{value: prizeAmount}("");
            require(success, "failed to withdraw money");
        }



    }

    function getAllWaves() view public returns(Wave[] memory) {
        return waves;
    }

    function getWaveCounter() public view returns (uint) {
        console.log("Our wavecounter is at %d", waveCounter);
        return waveCounter;
    }
}

