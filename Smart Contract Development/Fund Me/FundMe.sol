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

    function fund() public payable {
        require(
            msg.value.getConversionRate() > minimumUSD,
            "Not enough ETH sent."
        );
    }

    function withdraw() public {}
}
