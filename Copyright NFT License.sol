/**
 *Submitted for verification at Etherscan.io on 2020-05-11
*/

pragma solidity 0.5.14;

contract LexNFTLicense {

    address payable[] public allOwners;
    uint256[] public allWeights;

    // address public owner = 0x4744cda32bE7b3e75b9334001da9ED21789d4c0d;
    address public owner;
    address public buyer;
    uint256 public transactionValue;
    uint256 public weight;

    // setting the initial owner to the creator
    constructor() public {
        owner = 0x4744cda32bE7b3e75b9334001da9ED21789d4c0d;
        allOwners.push(0x4744cda32bE7b3e75b9334001da9ED21789d4c0d);
        // allWeights.push(100);
    }

    // seller makes offer by assigning the buyer
    function makeOffer(address _buyer, uint256 _transactionValue, uint256 _weight) public {
        require(msg.sender == owner);
        weight = _weight;
        allWeights.push(weight);
        transactionValue = _transactionValue;
        buyer = _buyer;
    }

    // buyer accepts offer by transacting this function
   function acceptOffer() public payable {
        require(msg.sender == buyer);
        require(msg.value == transactionValue);

        uint256 totalPayout = transactionValue / 100;

        // dripdrop by weight
        for (uint256 i = 0; i < allWeights.length; i++) {
            uint256 eachPayout;

            eachPayout = totalPayout * allWeights[i];

            allOwners[i].transfer(eachPayout);
        }

        owner = msg.sender;
        allOwners.push(msg.sender);
    }
}
