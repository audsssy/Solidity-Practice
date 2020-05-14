pragma solidity 0.5.14;

interface IToken {
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);

}

contract Payroll { // transfer msg.sender token to recipients per approved drop amount w/ msg.
    address public lexToken = 0x1463EfE7667e863C458DedAf1F2Fc7dE3A218453; // $LEX001
    address public consultant = 0x4744cda32bE7b3e75b9334001da9ED21789d4c0d; // Consultant LexDAO ETH address
    IToken private token = IToken(lexToken);

    event TokenDropped(string indexed message);

    function distribute(address source, uint256[] memory weights, address payable[] memory recipients, string memory message) public {
        require(weights.length == recipients.length);
        require(msg.sender == consultant);

        uint256 hundred = 100;
        uint256 totalAmount = (token.balanceOf(source) / hundred);

        for (uint256 i = 0; i < recipients.length; i++) {
            token.transfer(recipients[i], weights[i] * totalAmount);
        }

	    emit TokenDropped(message);
    }

    // function checkBalance(address source) public view returns (uint256) {
    //     uint256 hundred = 100;
    //     return (token.balanceOf(source) / hundred);
    // }

    // function disburse(address source, address recipient) public {
    //     require(msg.sender == consultant);
    //     token.transfer(recipient, token.balanceOf(source));
    // }
}
