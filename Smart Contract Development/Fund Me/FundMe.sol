// Add funds from users
// Withdraw fund to owner
// Set a minimum fund value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    uint256 public minimumUSD = 5e18;
    AggregatorV3Interface public feed =
        AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);

    function fund() public payable {
        require(
            getConversionRate(msg.value) > minimumUSD,
            "Not enough ETH sent."
        );
    }

    function withdraw() public {}

    function getPrice() public view returns (uint256) {
        (, int256 answer, , , ) = feed.latestRoundData();

        return uint256(answer * 1e10);
    }

    function getConversionRate(
        uint256 _ethAmount
    ) public view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 convertedRate = (ethPrice * _ethAmount) / 1e18;

        return convertedRate;
    }

    function getVersion() public view returns (uint256) {
        return feed.version();
    }
}
