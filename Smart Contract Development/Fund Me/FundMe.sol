// Add funds from users
// Withdraw fund to owner
// Set a minimum fund value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    uint256 public minimumUSD = 5;

    function fund() public payable {
        require(msg.value > 5, "Not enough ETH sent.");
    }

    function withdraw() public {}

    function getPrice() public {}

    function getConversionRate() public {}

    function getVersion() public view returns (uint256) {
        return
            AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306)
                .version();
    }
}
