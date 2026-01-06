// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../contracts/PausableToken.sol";

contract PausableTokenTest is Test {
    PausableToken token;
    address owner = address(this);
    address alice = address(0x1);

    function setUp() public {
        token = new PausableToken(1000);
    }

    function testInitialSupplyAssigned() public {
        assertEq(token.balanceOf(owner), 1000);
        assertEq(token.totalSupply(), 1000);
    }

    function testTransfer() public {
        token.transfer(alice, 100);
        assertEq(token.balanceOf(alice), 100);
        assertEq(token.balanceOf(owner), 900);
    }

    function testTransferInsufficientBalanceReverts() public {
        vm.prank(alice);
        vm.expectRevert(PausableToken.InsufficientBalance.selector);
        token.transfer(owner, 1);
    }

    function testPauseStopsTransfers() public {
        token.setPaused(true);

        vm.expectRevert(PausableToken.Paused.selector);
        token.transfer(alice, 1);
    }

    function testOnlyOwnerCanPause() public {
        vm.prank(alice);
        vm.expectRevert(PausableToken.NotOwner.selector);
        token.setPaused(true);
    }
}
