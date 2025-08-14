// SPDX-License-Identifier: MIT

pragma solidity 0.8.30;

contract ERC20 {
    string public name ;
    string public symbol ;
    uint8 constant public decimals = 18;
    uint public totalSupply;

    address public  owner;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    constructor(string memory _name , string memory _symbol , address _owner) {
        name = _name;
        symbol = _symbol;
        owner = _owner ;
    }

    function _mint(address to ,uint256 value) private {
        balanceOf[to] += value;
        totalSupply += value;

        emit Transfer(address(0), to, value);
    }

    function mint(address to, uint256 value) external   {
        require(msg.sender == owner);
        _mint(to, value);
    }

   function _burn(address from ,uint256 value) private {
        balanceOf[from] -= value;
        totalSupply -= value;

        emit Transfer(from, address(0), value);
    }

    function burn(address from, uint256 value) external   {
        require(msg.sender == owner);
        _mint(from, value);
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