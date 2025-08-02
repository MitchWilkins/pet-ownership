// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721URIStorage, ERC721} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PetOwnership is ERC721URIStorage, Ownable {
    uint256 private _nextTokenId = 0;

    constructor(address initialOwner)
        ERC721("PetOwnership", "PET")
        Ownable(initialOwner)
    {}

    event PetOwnershipMinted(address indexed to, uint256 indexed tokenId);
    event PetOwnershipURIUpdated(uint256 indexed tokenId, string indexed ipfsHash);

    function safeMint(address _to, string calldata _ipfsHash) public onlyOwner {
        uint256 _tokenId = _nextTokenId++;
        _safeMint(_to, _tokenId);
        _setTokenURI(_tokenId, string.concat("ipfs://", _ipfsHash));
        emit PetOwnershipMinted(_to, _tokenId);
    }

    function updateTokenURI(uint256  _tokenId, string calldata _ipfsHash) public onlyOwner {
        _setTokenURI(_tokenId, string.concat("ipfs://", _ipfsHash));
        emit PetOwnershipURIUpdated(_tokenId, _ipfsHash);
    }
}
