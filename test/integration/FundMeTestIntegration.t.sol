// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";

import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {Fund, Withdraw} from "../../script/Interactions.s.sol";

contract InteractionsTest is Test {
    FundMe fundMe;

    uint256 constant SEND_VALUE = .1 ether;
    uint256 constant INITIAL_BALANCE = 10 ether;
    uint256 constant GAS_PRICE = 1;

    address public constant USER = address(1);

    function setUp() external {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, INITIAL_BALANCE);
    }

    function testUserCanFundInteractions() public {
        Fund fundContract = new Fund();
        fundContract.fund(address(fundMe));

        Withdraw withdrawContract = new Withdraw();
        withdrawContract.withdraw(address(fundMe));

        assert(address(fundMe).balance == 0);
    }
}
