// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {SimpleStorage} from "../Simple Storage/SimpleStorage.sol";

contract StorageFactory {
    SimpleStorage[] public listOfSimpleStorageContracts;

    function createSimpleStorageContract() public {
        SimpleStorage newSimpleStorageContract = new SimpleStorage();
        listOfSimpleStorageContracts.push(newSimpleStorageContract);
    }
}
