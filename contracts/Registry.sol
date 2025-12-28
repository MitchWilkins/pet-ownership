// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";

abstract contract Registry is AccessControl {
    error CallerNotMinter(address caller);

    constructor(){
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function add(address _account) external virtual onlyRole(DEFAULT_ADMIN_ROLE) {
        
    }

    function remove(address _account) external virtual onlyRole(DEFAULT_ADMIN_ROLE) {
    
    }

}