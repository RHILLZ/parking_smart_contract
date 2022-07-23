//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.13;

import "./AuthorizedOwner.sol";

contract ParkingSpot is AuthorizedOwner {
    // enums
    enum SpotStatuses {
        EMPTY,
        TAKEN
    }
    SpotStatuses public status;

    //events
    event Occupied(address _occupant, uint256 _value);

    // custom modifiers
    modifier checkIfEmpty() {
        require(status == SpotStatuses.EMPTY, "Spot is currently taken.");
        _;
    }
    modifier checkAmount(uint256 _amount) {
        require(msg.value > _amount, "Not enough funds!");
        _;
    }

    // contructor
    constructor() {
        super;
        status = SpotStatuses.EMPTY;
    }

    // methods
    function parkInSpot() external payable checkAmount(0.5 ether) checkIfEmpty {
        status = SpotStatuses.TAKEN;
        owner.transfer(msg.value);
        emit Occupied(msg.sender, msg.value);
    }

    function freeUpSpot() external checkAuthorization {
        status = SpotStatuses.EMPTY;
    }
}
