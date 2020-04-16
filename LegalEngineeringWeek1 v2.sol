pragma solidity 0.5.14;

contract Stamford {
    address payable public stamford = 0x4744cda32bE7b3e75b9334001da9ED21789d4c0d;
    string public stuff;
    uint256 public money;

    function saySomething (string memory newStuff) payable public {
        stuff = newStuff;
    }

    function newStamfordAddress (address payable _stamford) payable public {
        require(msg.sender == stamford);
        stamford = _stamford;
    }

    function payMoney (uint256 _money) payable public {
        stamford.transfer(_money);
    }
}
