// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../Simple Storage/SimpleStorage.sol";

contract StorageFactory {
    SimpleStorage public simpleStorage;

    function createSimpleStorageContract() public {
        simpleStorage = new SimpleStorage();
    }
}
