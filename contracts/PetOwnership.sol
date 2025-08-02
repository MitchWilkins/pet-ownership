// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721URIStorage, ERC721} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PetOwnership is ERC721URIStorage, Ownable {
    constructor(address initialOwner)
        ERC721("PetOwnership", "PET")
        Ownable(initialOwner)
    {}

    event PetOwnershipMinted(address indexed to, uint256 indexed tokenId);

    function safeMint(address _to, uint256 _tokenId, string calldata _ipfsHash) public onlyOwner {
        _safeMint(_to, _tokenId);
        _setTokenURI(_tokenId, string.concat("ipfs://", _ipfsHash));
        emit PetOwnershipMinted(_to, _tokenId);
    }
}
