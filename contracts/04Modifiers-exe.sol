// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract PausableToken {
    address public owner;
    bool public paused;
    mapping(address => uint) public balances;

    constructor(){
        owner = msg.sender;
        paused = false;
        balances[owner] = 1000;
    }

    modifier onlyOwner () {
        // Only owner can perform further actions
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    // check if the contract is not paused
    modifier notPaused() {
        require(paused == false, "Contract is paused");
        _;
    }

    // Pause the contract 
    function pause () public {
        paused = true;
    }

    // unpause the contract
    function unpause() public  {
        paused = false;
    }

    // Transfer tokens
    function tansfer(address to, uint amount) public notPaused {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        balances[to] += amount;
    }


}