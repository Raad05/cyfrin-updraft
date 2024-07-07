// Add funds from users
// Withdraw fund to owner
// Set a minimum fund value in USD
// Note: Solidity doesn't work well with decimals, so for any general calculations, try to multiply, then divide

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

// imports
import {PriceConverter} from "./PriceConverter.sol";

// custom errors
error NotEnoughETHSent();
error UnableToWithdrawMoney();
error NotOwner();

contract FundMe {
    // state variables
    using PriceConverter for uint256;
    address[] public funders;
    mapping(address funder => uint256 amountFunded)
        public addressToAmountFunded;

    // constant variables
    uint256 public constant MINIMUM_USD = 5e18;

    // immutable variables
    address public immutable i_owner;

    // constructor
    constructor() {
        i_owner = msg.sender;
    }

    // functions
    function fund() public payable {
        // check if fund > minimum value
        if (msg.value.getConversionRate() < MINIMUM_USD) {
            revert NotEnoughETHSent();
        }

        // push funder info on-chain
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        // reset funders amount
        for (uint256 i = 0; i < funders.length; i++) {
            address funder = funders[i];
            addressToAmountFunded[funder] = 0;
        }

        // reset funders
        funders = new address[](0);

        // withdraw fund to owner
        address ownerAddress = payable(msg.sender);
        (bool sent, ) = ownerAddress.call{value: address(this).balance}("");
        if (!sent) {
            revert UnableToWithdrawMoney();
        }
    }

    // modifiers
    modifier onlyOwner() {
        if (msg.sender != i_owner) {
            revert NotOwner();
        }
        _;
    }
}
