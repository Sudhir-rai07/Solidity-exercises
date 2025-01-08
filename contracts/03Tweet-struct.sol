// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract TwitterStruct {
    // Create a user struct {author, content, timestamp likes}
    struct Tweet{
        address author;
        string content;
        uint256 timestamp;
        uint128 likes;
    }

    mapping(address => Tweet[]) public tweets;

    function createTweet(string memory _tweet) public {
        Tweet memory newTweet = Tweet({
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes : 0
        });

        // push tweet
        tweets[msg.sender].push(newTweet);
    }

    // Test Tweets

    function getTweet(address _owner, uint128 _i) public view returns (Tweet memory) {
        return tweets[_owner][_i];
    }

    // Get all tweets
    function getAllTweets(address _owner) public view returns (Tweet[] memory) {
        return tweets[_owner];
    }
}