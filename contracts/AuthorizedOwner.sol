//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.13;

contract AuthorizedOwner {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    modifier checkAuthorization() {
        require(msg.sender == owner, "You are not Authorized!");
        _;
    }
}
