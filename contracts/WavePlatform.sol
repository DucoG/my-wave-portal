// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint waveCounter;
    mapping(address => uint) public wavesPerPerson;
    //make mapping of user structs

    constructor() {
        console.log("Hello, this is a smart contract");
        waveCounter = 0;
    }

    function wave() public {
        waveCounter += 1;
        wavesPerPerson[msg.sender] += 1;
        console.log(msg.sender, " just waved at you for the ", wavesPerPerson[msg.sender], "th time!");
    }

    function getWaveCounter() public view returns (uint) {
        console.log("Our wavecounter is at %d", waveCounter);
        return waveCounter;
    }
}

