//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Coin{
    address owner;
    uint  amount;
 

    constructor(){
        owner = msg.sender;
    }

   mapping(address => uint) public  coins;

    // Even for minting
    event Mint(address _address, uint token);

    // event for coin transfer
    event Transaction(address _from, address _to, uint _amount);

    // Mint
    function mint(uint _amount)public{
        require(msg.sender == owner, "Buddy, You are not owner of this coin");
        coins[owner] += _amount;

        // emit event
        emit Mint(owner, _amount);
    }

    // Send
    function send(address _to, uint _amount) public {
        require(coins[msg.sender] >= _amount, "Insufficient Balance");
        coins[msg.sender] -= _amount;
        coins[_to] += _amount;

        // Emit event
        emit Transaction(msg.sender, _to, _amount);
    }
}