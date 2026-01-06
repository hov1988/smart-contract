// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../contracts/SimpleVault.sol";

contract SimpleVaultTest is Test {
    SimpleVault vault;
    address owner = address(this);
    address user = address(0x1);

    function setUp() public {
        vault = new SimpleVault();
        vm.deal(user, 10 ether);
    }

    function testDeposit() public {
        vm.prank(user);
        vault.deposit{value: 1 ether}();

        assertEq(address(vault).balance, 1 ether);
        assertEq(vault.totalDeposits(), 1 ether);
    }

    function testDepositZeroReverts() public {
        vm.prank(user);
        vm.expectRevert(SimpleVault.ZeroAmount.selector);
        vault.deposit{value: 0}();
    }

    function testWithdrawByOwner() public {
        vm.prank(user);
        vault.deposit{value: 2 ether}();

        vault.withdraw(1 ether);
        assertEq(address(vault).balance, 1 ether);
    }

    function testWithdrawByNonOwnerReverts() public {
        vm.prank(user);
        vm.expectRevert(SimpleVault.NotOwner.selector);
        vault.withdraw(1 ether);
    }

    function testWithdrawTooMuchReverts() public {
        vm.prank(user);
        vault.deposit{value: 1 ether}();

        vm.expectRevert(
            abi.encodeWithSelector(
                SimpleVault.InsufficientBalance.selector,
                2 ether,
                1 ether
            )
        );
        vault.withdraw(2 ether);
    }
}
