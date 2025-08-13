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
        return  _transfer(msg.sender , to , amount );
    }

    function transferFrom(address from, address to, uint256 amount) public  returns  (bool) {
        require(allowence[from][msg.sender] >= amount , "Insufficient Allowence");
        allowence[from][msg.sender] -= amount;

        return  _transfer(from, to, amount);
    }

    function approve(address spender, uint256 amount) public  returns  (bool) {
        allowence[msg.sender][spender] += amount;

        return true; 
    }

    function _transfer(address from ,address to , uint amount) private  returns  (bool) {
        require(balanceOf[from] >= amount , "Insufficient Balance");
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;

        return true;
    }
}


