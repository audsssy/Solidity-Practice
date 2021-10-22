pragma solidity ^0.8.7;
// SPDX-License-Identifier: GPL-3.0-or-later

contract Shoutout {
    address public initiator;
    uint public memberCount;
    uint public maxScore = 6;
    uint public topicCount;
    
    struct member {
        bool isMember;
        uint256 score;
    }

    struct topic {
        string title;
        uint yea;
        uint nay;
        bool didPass;
        bool didVeto;
    }

    mapping(address => member) public members;
    mapping(uint => topic) public topics;
        
    constructor() {
        initiator = msg.sender;
        memberCount +=1;
        members[msg.sender].score = 10;
        members[msg.sender].isMember = true;
    }
    
    function addMember(address newMember) public onlyInitiator {
        memberCount +=1;
        members[newMember].score = 10;
        members[newMember].isMember = true;
    } 
    
    function giveShoutout(uint256[] calldata scores, address[] calldata recipients) public {
        require(members[msg.sender].isMember, "Not a member!");
        require(recipients.length > 0, "Must include a recipieint!");
        require(recipients.length == scores.length, "Recipient & scores mismatch!");
        
        uint256 sum;
        
        for (uint256 i = 0; i < recipients.length; i++) {
            sum += scores[i];
            require(sum < maxScore, "Total scores given is greater than max!");
            members[recipients[i]].score += scores[i];
            members[msg.sender].score -= scores[i];    
        }
    }
    
    function submitVoteTopic(string calldata _topic) public {
        require(members[msg.sender].isMember, "Not a member!");
        
        topics[topicCount].title = _topic;
        topicCount++;
    }
    
    function voteTopic(uint _topicNumber, uint _yeaOrNay, uint _vote) public {
        require(members[msg.sender].isMember, "member!");
        require(members[msg.sender].score >= _vote, "vote > score");
        
        if (_yeaOrNay == 0) {
            topics[_topicNumber].nay += _vote;
            if (topics[_topicNumber].nay > topics[_topicNumber].yea) {topics[_topicNumber].didPass = false; } 
        } else {
            topics[_topicNumber].yea += _vote;
            if (topics[_topicNumber].yea > topics[_topicNumber].nay) {topics[_topicNumber].didPass = true; } 
        }
    }
    
    function veto(uint _topicNumber) public onlyInitiator {
        topics[_topicNumber].didVeto = true;    
    }
    
    modifier onlyInitiator() {
        require(msg.sender == initiator, "!admin");
        _;
    }
}
