// Add funds from users
// Withdraw fund to owner
// Set a minimum fund value in USD
// Note: Solidity doesn't work well with decimals, so for any general calculations, try to multiply, then divide

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {PriceConverter} from "./PriceConverter.sol";

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
        require(
            msg.value.getConversionRate() > MINIMUM_USD,
            "Not enough ETH sent."
        );
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
        require(sent, "Unable to withdraw money");
    }

    // modifiers
    modifier onlyOwner() {
        require(msg.sender == i_owner, "You are not the owner.");
        _;
    }
}
