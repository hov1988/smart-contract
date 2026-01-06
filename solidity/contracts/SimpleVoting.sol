// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title SimpleVoting
contract SimpleVoting {
    enum ProposalState { Active, Closed }

    address public owner;
    ProposalState public state;

    mapping(address => bool) public hasVoted;
    mapping(uint8 => uint256) public votes;

    /// -------- Errors --------
    error NotOwner();
    error VotingClosed();
    error AlreadyVoted();
    error InvalidOption();

    /// -------- Events --------
    event VoteCast(address indexed voter, uint8 option);
    event VotingClosedEvent();

    /// -------- Modifiers --------
    modifier onlyOwner() {
        if (msg.sender != owner) revert NotOwner();
        _;
    }

    modifier whenActive() {
        if (state != ProposalState.Active) revert VotingClosed();
        _;
    }

    constructor() {
        owner = msg.sender;
        state = ProposalState.Active;
    }

    /// -------- Logic --------
    function vote(uint8 option) external whenActive {
        if (hasVoted[msg.sender]) revert AlreadyVoted();
        if (option > 2) revert InvalidOption(); // example: 0,1,2 allowed

        hasVoted[msg.sender] = true;
        votes[option]++;

        emit VoteCast(msg.sender, option);
    }

    function closeVoting() external onlyOwner {
        state = ProposalState.Closed;
        emit VotingClosedEvent();
    }
}
