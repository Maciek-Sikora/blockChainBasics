// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "./Basic1.sol";

// alternatywnie zamiast pisać importa można skorzystać z dziedziczenia
// contract StorageFactory is SimpleStorage{ 
contract StorageFactory {

    SimpleStorage [] public simpleStorageContainer;

    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageContainer.push(simpleStorage);
    }

    function sfStore(uint256 _simpleSorageIndex  ,int16 _numer) public {
        // Do interakcji z konrtrakrem potrzwba Address( z tab) i ABI (Application Binary Interface)
        SimpleStorage simpleStorage = SimpleStorage(address(simpleStorageContainer[_simpleSorageIndex]));
        simpleStorage.store(_numer);

    }
    function sfGet(uint256 _simpleSorageIndex ) public view returns (int16) {
        return SimpleStorage(address(simpleStorageContainer[_simpleSorageIndex])).zwroc();
    }
}