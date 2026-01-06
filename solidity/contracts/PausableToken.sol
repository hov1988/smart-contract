// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title PausableToken
contract PausableToken {
    string public name = "DemoToken";
    string public symbol = "DMT";
    uint8 public decimals = 18;
    uint256 public totalSupply;

    address public owner;
    bool public paused;

    mapping(address => uint256) public balanceOf;

    /// -------- Errors --------
    error Paused();
    error NotOwner();
    error InsufficientBalance();

    /// -------- Events --------
    event Transfer(address indexed from, address indexed to, uint256 value);
    event PausedStateSet(bool paused);

    /// -------- Modifiers --------
    modifier onlyOwner() {
        if (msg.sender != owner) revert NotOwner();
        _;
    }

    modifier whenNotPaused() {
        if (paused) revert Paused();
        _;
    }

    constructor(uint256 initialSupply) {
        owner = msg.sender;
        totalSupply = initialSupply;
        balanceOf[msg.sender] = initialSupply;
    }

    /// -------- Logic --------
    function transfer(address to, uint256 amount) external whenNotPaused {
        if (balanceOf[msg.sender] < amount) revert InsufficientBalance();

        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;

        emit Transfer(msg.sender, to, amount);
    }

    function setPaused(bool _paused) external onlyOwner {
        paused = _paused;
        emit PausedStateSet(_paused);
    }
}
