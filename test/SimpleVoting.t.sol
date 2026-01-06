// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../contracts/SimpleVoting.sol";

contract SimpleVotingTest is Test {
    SimpleVoting voting;
    address alice = address(0x1);
    address bob = address(0x2);

    function setUp() public {
        voting = new SimpleVoting();
    }

    function testVote() public {
        vm.prank(alice);
        voting.vote(1);

        assertEq(voting.votes(1), 1);
    }

    function testDoubleVoteReverts() public {
        vm.prank(alice);
        voting.vote(0);

        vm.prank(alice);
        vm.expectRevert(SimpleVoting.AlreadyVoted.selector);
        voting.vote(0);
    }

    function testInvalidOptionReverts() public {
        vm.prank(alice);
        vm.expectRevert(SimpleVoting.InvalidOption.selector);
        voting.vote(5);
    }

    function testCloseVotingStopsVotes() public {
        voting.closeVoting();

        vm.prank(bob);
        vm.expectRevert(SimpleVoting.VotingClosed.selector);
        voting.vote(1);
    }

    function testOnlyOwnerCanCloseVoting() public {
        vm.prank(alice);
        vm.expectRevert(SimpleVoting.NotOwner.selector);
        voting.closeVoting();
    }
}
