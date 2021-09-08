// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {

    //event NewWave(address indexed from, uint timestamp, string message);

    struct Wave {
        string message;
        address waver;
        uint timestamp;
    }

    Wave[] waves;

    uint waveCounter;
    mapping(address => uint) public wavesPerPerson;

    constructor() payable {
        console.log("Hello, this is a smart contract");
        waveCounter = 0;
    }

    // wave with text
    function wave(string memory _message) public {
        waveCounter += 1;
        wavesPerPerson[msg.sender] += 1;
        console.log(msg.sender, " just waved at you for the ", wavesPerPerson[msg.sender], "th time, with the following message:");
        console.log("Got message: %s", _message);
        waves.push(Wave(_message, msg.sender, block.timestamp));
        //emit NewWave(msg.sender, block.timestamp, _message);

        uint prizeAmount = 0.0001 ether;
        require(prizeAmount <= address(this).balance, "Contract out of money!");
        (bool success,) = (msg.sender).call{value: prizeAmount}("");
        require(success, "failed to withdraw money");


    }

    function getAllWaves() view public returns(Wave[] memory) {
        return waves;
    }

    function getWaveCounter() public view returns (uint) {
        console.log("Our wavecounter is at %d", waveCounter);
        return waveCounter;
    }
}

