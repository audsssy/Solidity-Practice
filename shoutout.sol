pragma solidity ^0.8.7;
// SPDX-License-Identifier: GPL-3.0-or-later

library SafeMath { // arithmetic wrapper for unit under/overflow check
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a);
        return c;
    }
    
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a);
        uint256 c = a - b;
        return c;
    }
    
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        require(c / a == b);
        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0);
        uint256 c = a / b;
        return c;
    }
}

contract Shoutout {
    using SafeMath for uint256;
    
    address public initiator;
    uint public memberCount;
    
    struct member {
        bool isMember;
        uint256 score;
    }

    mapping(address => member) public members;
        
        
    constructor() {
        initiator = msg.sender;
        memberCount += 1;
        members[msg.sender].score = 10;
        members[msg.sender].isMember = true;
    }
    
    function addMember(address newMember) public onlyInitiator {
        memberCount += 1;
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
            require(sum < 6, "Total scores given is greater than 5!");
            members[recipients[i]].score += scores[i];
            members[msg.sender].score -= scores[i];    
            
        }
    }
    
    modifier onlyInitiator() {
        require(msg.sender == initiator, "!admin");
        _;
    }
}
