// Add funds from users
// Withdraw fund to owner
// Set a minimum fund value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract FundMe {
    function fund() public payable {
        require(msg.value > 1e18, "Not enough ETH sent.");
    }

    function withdraw() public {}
}
