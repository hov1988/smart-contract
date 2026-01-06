// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title SimpleVault
/// @author YourName
/// @notice ETH vault with owner-based access control
contract SimpleVault {
    address public owner;
    uint256 public totalDeposits;

    /// ---------------- Errors ----------------
    error NotOwner();
    error ZeroAmount();
    error InsufficientBalance(uint256 requested, uint256 available);

    /// ---------------- Events ----------------
    event Deposited(address indexed from, uint256 amount);
    event Withdrawn(address indexed to, uint256 amount);
    event OwnershipTransferred(address indexed oldOwner, address indexed newOwner);

    /// ---------------- Modifiers ----------------
    modifier onlyOwner() {
        if (msg.sender != owner) revert NotOwner();
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    /// ---------------- Logic ----------------
    function deposit() external payable {
        if (msg.value == 0) revert ZeroAmount();

        totalDeposits += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) external onlyOwner {
        uint256 balance = address(this).balance;
        if (amount > balance) revert InsufficientBalance(amount, balance);

        payable(owner).transfer(amount);
        emit Withdrawn(owner, amount);
    }

    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "zero address");
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
