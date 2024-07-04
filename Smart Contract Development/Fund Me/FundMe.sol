// Add funds from users
// Withdraw fund to owner
// Set a minimum fund value in USD
// Note: Solidity doesn't work well with decimals, so for any general calculations, try to multiply, then divide

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;
    uint256 public minimumUSD = 5e18;

    address[] public funders;
    mapping(address funder => uint256 amountFunded)
        public addressToAmountFunded;

    function fund() public payable {
        // check if fund > minimum value
        require(
            msg.value.getConversionRate() > minimumUSD,
            "Not enough ETH sent."
        );
        // push funder info on-chain
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public {
        // reset funders amount
        for (uint256 i = 0; i < funders.length; i++) {
            address funder = funders[i];
            addressToAmountFunded[funder] = 0;
        }
        // reset funders
        funders = new address[](0);
    }
}
