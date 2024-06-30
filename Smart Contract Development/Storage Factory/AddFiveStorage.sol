// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {SimpleStorage} from "../Simple Storage/SimpleStorage.sol";

contract AddFiveStorage is SimpleStorage {
    function store(uint256 _favoriteNumber) public override {
        myFavoriteNumber = _favoriteNumber + 5;
    }
}
