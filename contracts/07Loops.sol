// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract ExpenceTeacker {
    // Create a struct of Expence
    // Fields : user, description, amount
    // Create a function to get total expence

    struct Expence {
        address user;
        string description;
        uint amount;
    }

    Expence[] public expences;

    constructor() {
        expences.push(Expence(msg.sender, "Movie", 2));
        expences.push(Expence(msg.sender, "Cloths", 28));
        expences.push(Expence(msg.sender, "Books", 12));
        expences.push(Expence(msg.sender, "Party", 222));
    }

    // fn to add a new expence
    function addExpence(string memory _description, uint _amount) public {
        Expence memory newExpence = Expence({
            user : msg.sender,
            description : _description,
            amount: _amount
        });

        // Push the expence to expences
        expences.push(Expence(msg.sender, newExpence.description, newExpence.amount));
    }

    // fn to get total expence by user address
    function totalEx(address _user) public view returns(uint){
        uint total;
        for(uint i = 0; i < expences.length; i++){
            if(expences[i].user == _user){
                total += expences[i].amount;
            }
        }

        return total;
    }

}
