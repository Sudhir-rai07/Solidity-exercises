// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TwitterStruct {
    // Create a user struct {author, content, timestamp likes}
    struct Tweet {
        uint256 id;
        address author;
        string content;
        uint256 timestamp;
        uint128 likes;
    }

    // Maximum tweet length
    uint16 MAX_TWEET_LENGTH = 280;

    // Mapping address to tweets
    mapping(address => Tweet[]) public tweets;
    address public owner;

    // Constructor for Tweets
    //
    // Sets owner to msg.sender
    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "You are not the owner dude!");
        _;
    }

    // Fn to change length of MAX_TWEET_LENGTH. Only accessable by owner
    function changeTweetLength(uint16 _newMaxTweetLength) public onlyOwner {
        MAX_TWEET_LENGTH = _newMaxTweetLength;
    }

    // Creates a new tweet with id, tweet add timestamp
    function createTweet(string memory _tweet) public {
        // Condition
        // If tweet length is > 280, revert
        require(bytes(_tweet).length <= MAX_TWEET_LENGTH, "Too long bro!");

        Tweet memory newTweet = Tweet({
            id: tweets[msg.sender].length,
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0
        });

        // push tweet
        tweets[msg.sender].push(newTweet);
    }

    // Fn to like a tweet
    //
    // Cheks for the tweet if tweet not found. throws an error
    //
    function likeTweet(address author, uint256 id) external {
        require(tweets[author][id].id == id, "Tweet not found");
        tweets[author][id].likes++;
    }

    // Fn too unlike the tweet.
    //
    // Find the tweet and check if tweet more than 0 likes
    // If not, it throws error
    function unlikeTweet(address author, uint256 id) external {
        require(tweets[owner][id].id == id, "Tweet not found");
        require(tweets[author][id].likes > 0, "Mannn! Really??");
        tweets[author][id].likes--;
    }

    // Get a tweet
    //
    // Returns a tweet
    function getTweet(uint128 _i) public view returns (Tweet memory) {
        return tweets[msg.sender][_i];
    }

    // Get all tweets
    //
    // Returns array of tweets
    function getAllTweets(address _owner) public view returns (Tweet[] memory) {
        return tweets[_owner];
    }
}
 