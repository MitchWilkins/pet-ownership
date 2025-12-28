// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Registry} from "./Registry.sol";

contract ShelterRegistry is Registry {
    bytes32 public constant SHELTER_ROLE = keccak256("SHELTER_ROLE");

    constructor(){
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function add(address _account) external override onlyRole(DEFAULT_ADMIN_ROLE) {
        _grantRole(SHELTER_ROLE, _account);
    }

    function remove(address _account) external override onlyRole(DEFAULT_ADMIN_ROLE) {
        _revokeRole(SHELTER_ROLE, _account);
    }

    function isShelter(address _shelter) public view returns (bool) {
        return hasRole(SHELTER_ROLE, _shelter);
    }

}