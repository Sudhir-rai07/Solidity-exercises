// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Will {
    address owner;
    uint    fortune;
    bool    decesed;

// Constructor to set fortune of great Grand Father
    constructor() payable {
        owner = msg.sender;
        fortune = msg.value;
        decesed = false;
    }

    // Map account with amount
    address payable[] familyWallet;

    // Map account with inheritance
    mapping (address => uint) inheritance;

    // Modifier to allow privilage to only owner
    modifier onlyOwner(){
        require(owner == msg.sender, "You are not authorized. Sir!");
        _;
    }

    // If GGF is decesed
    modifier GGFdecesed(){
        require(decesed == true, "Whattt!!, GGF is alive.");
        _;
    }


    // Set inheritance
    function setInheritance(address payable _wallet, uint _amount) public {
        familyWallet.push(_wallet);
        inheritance[_wallet] = _amount;

    } 

    // payout
    function payout() public GGFdecesed {
        for(uint i=0; i<familyWallet.length; i++){
            familyWallet[i].transfer(inheritance[familyWallet[i]]); 
            //Explaination
            /*
            * Family Wallet holds wallet_address of the ggc(Great grand children)
            * Inheritance is a mapping, That is mapping walletAddress with amount
            * So FamilyWallet at [i] is getting paid the ammout set in `inheritance` with their wallet address
            */
        }
    }

    // Set decesed
    function hasDecesed()public {
        decesed=true;
        payout();
    }



}