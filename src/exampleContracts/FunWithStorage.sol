// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract FunWithStorage {
    uint256 favoriteNumber; // Stored at slot 0
    bool someBool; // Stored at slot 1
    uint256[] myArray; // Lenght is stored at slot 2, objs keccak256(2), since 2 is the
    // storage slot for myArray
    mapping(uint256 => bool) myMap; // an empty slot is held at slot 3
    // the elements will be stored at keccak256(h(k) * p)
    // p: the storage slot (aka 3)
    // k: the key in hex
    // h: some function based on the type, for uint256- > just pads the hex

    uint256 constant NOT_IN_STORAGE = 123;
    uint256 immutable i_not_in_storage;

    constructor() {
        favoriteNumber = 25; // See stored spot above // SSTORE
        someBool = true; // See stored spot above // SSTORE
        myArray.push(222); // SSTORE
        myMap[0] = true; // SSTORE
        i_not_in_storage = 123;
    }

    function doStuff() public {
        uint256 newVar = favoriteNumber + 1; // SLOAD
        bool otherVar = someBool; // SLOAD
        // ^^ memory variables
    }
}
