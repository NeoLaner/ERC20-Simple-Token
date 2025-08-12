// SPDX-License-Identifier: MIT

pragma solidity 0.8.30;

contract ERC20 {
    string constant public  name = "MyTokenName";
    string constant public  symbol = "MTN";
    uint8 constant public  decimals = 18;

    uint public totalSupply; 
    mapping (address account => uint) balanceOf;

    function  transfer(address to  ,uint amount ) public returns (bool) {
        require(balanceOf[msg.sender] >= amount , "Insufficient Balance");
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;

        return true;
    }

}
