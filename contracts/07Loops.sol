// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract ExpenseTeacker {
    // Create a struct of Expense
    // Fields : user, description, amount
    // Create a function to get total expense

    struct Expense {
        address user;
        string description;
        uint amount;
    }

    Expense[] public expenses;

    constructor() {
        expenses.push(Expense(msg.sender, "Movie", 2));
        expenses.push(Expense(msg.sender, "Cloths", 28));
        expenses.push(Expense(msg.sender, "Books", 12));
        expenses.push(Expense(msg.sender, "Party", 222));
    }

    // fn to add a new expense
    function addExpense(string memory _description, uint _amount) public {
        Expense memory newExpense = Expense({
            user : msg.sender,
            description : _description,
            amount: _amount
        });

        // Push the expense to expenses
        expenses.push(Expense(msg.sender, newExpense.description, newExpense.amount));
    }

    // fn to get total expense by user address
    function totalEx(address _user) public view returns(uint){
        uint total;
        for(uint i = 0; i < expenses.length; i++){
            if(expenses[i].user == _user){
                total += expenses[i].amount;
            }
        }

        return total;
    }

}
