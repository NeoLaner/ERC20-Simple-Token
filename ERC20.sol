// SPDX-License-Identifier: MIT

pragma solidity 0.8.30;

contract ERC20 {
    string constant public name = "MyTokenName";
    string constant public symbol = "MTN";
    uint8 constant public decimals = 18;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    uint public totalSupply;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    constructor(uint256 initialSupply) {
        totalSupply = initialSupply;
        balanceOf[msg.sender] = initialSupply;
    }

    function transfer(address to, uint256 value) external returns (bool) {
        return _transfer(msg.sender, to, value);
    }

    function transferFrom(address from, address to, uint256 value) external returns (bool) {
        require(allowance[from][msg.sender] >= value, "Insufficient Allowance");
        allowance[from][msg.sender] -= value;

        emit Approval(from, msg.sender, allowance[from][msg.sender]);

        return _transfer(from, to, value);
    }

    function approve(address spender, uint256 value) external returns (bool) {
        allowance[msg.sender][spender] = value; // Using direct assignment to avoid potential issues with +=

        emit Approval(msg.sender, spender, value);

        return true;
    }

    function _transfer(address from, address to, uint256 value) private returns (bool) {
        require(balanceOf[from] >= value, "Insufficient Balance");

        balanceOf[from] -= value;
        balanceOf[to] += value;

        emit Transfer(from, to, value);

        return true;
    }
}