// SPDX-License-Identifier: MIT

pragma solidity 0.8.30;

contract ERC20 {
    string constant public  name = "MyTokenName";
    string constant public  symbol = "MTN";
    uint8 constant public  decimals = 18;

    uint public totalSupply; 
    mapping (address  => uint) public  balanceOf;
    mapping (address => mapping(address  => uint)) public allowence;

    function  transfer(address to  ,uint amount ) public returns (bool) {
        require(balanceOf[msg.sender] >= amount , "Insufficient Balance");
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;

        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public  returns  (bool) {
        allowence[sender][msg.sender] -= amount;

        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        
        return  true;
    }

    function approve(address spender, uint256 amount) public  returns  (bool) {
        allowence[msg.sender][spender] += amount;

        return true; 
    }
}

