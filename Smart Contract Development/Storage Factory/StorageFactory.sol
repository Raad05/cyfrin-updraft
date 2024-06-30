// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {SimpleStorage} from "../Simple Storage/SimpleStorage.sol";

contract StorageFactory {
    SimpleStorage[] public listOfSimpleStorageContracts;

    function createSimpleStorageContract() public {
        SimpleStorage newSimpleStorageContract = new SimpleStorage();
        listOfSimpleStorageContracts.push(newSimpleStorageContract);
    }

    function sfStore(
        uint256 _simpleStorageIdx,
        uint256 _newSimpleStorageNumber
    ) public {
        // Address
        // ABI
        SimpleStorage mySimpleStorage = listOfSimpleStorageContracts[
            _simpleStorageIdx
        ];
        mySimpleStorage.store(_newSimpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIdx) public view returns (uint256) {
        SimpleStorage mySimpleStorage = listOfSimpleStorageContracts[
            _simpleStorageIdx
        ];

        return mySimpleStorage.retrieve();
    }
}
