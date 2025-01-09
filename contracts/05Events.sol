// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract EvantExample {
    // Add a event "NewUserRegistered" with two args
    // user as an address
    // username as string

    // Event
    event NewUserRegistered(address indexed user, string username);

    // Struct of a User
    struct User {
        string username;
        uint8 age;
    }

    // Mapping an address to a user
    mapping(address => User) public users;

    // Creating a new user
    function registerUser(string memory _username, uint8 _age) public {
        User storage newUser = users[msg.sender];
        newUser.username = _username;
        newUser.age = _age;

        // Fire an event
        emit NewUserRegistered(msg.sender, newUser.username);
    }
}
