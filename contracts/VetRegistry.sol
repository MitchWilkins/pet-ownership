// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Registry} from "./Registry.sol";

contract VetRegistry is Registry {
    bytes32 public constant VET_ROLE = keccak256("VET_ROLE");

    constructor() {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function add(address _account) external override onlyRole(DEFAULT_ADMIN_ROLE) {
        _grantRole(VET_ROLE, _account);
    }

    function remove(address _account) external override onlyRole(DEFAULT_ADMIN_ROLE) {
        _revokeRole(VET_ROLE, _account);
    }

    function isVet(address _vet) public view returns (bool) {
        return hasRole(VET_ROLE, _vet);
    }

}