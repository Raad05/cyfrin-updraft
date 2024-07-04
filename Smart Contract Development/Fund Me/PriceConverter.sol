// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice() internal view returns (uint256) {
        AggregatorV3Interface feed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        (, int256 answer, , , ) = feed.latestRoundData();

        return uint256(answer * 1e10);
    }

    function getConversionRate(
        uint256 _ethAmount
    ) internal view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 convertedRate = (ethPrice * _ethAmount) / 1e18;

        return convertedRate;
    }

    function getVersion() internal view returns (uint256) {
        AggregatorV3Interface feed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );

        return feed.version();
    }
}
