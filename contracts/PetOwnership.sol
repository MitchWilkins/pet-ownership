// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721URIStorage, ERC721} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "./VetRegistry.sol";
import "./ShelterRegistry.sol";

contract PetOwnership is ERC721URIStorage, Pausable, Ownable {
    uint256 private _nextTokenId = 1000;
    address private _vetRegistry;
    address private _shelterRegistry;

    event PetOwnershipMinted(address indexed to, uint256 indexed tokenId);
    event PetOwnershipURIUpdated(uint256 indexed tokenId, string indexed ipfsHash);

    modifier isTokenOwner(uint256 _tokenId) {
        require (
            owner() == msg.sender
            || ownerOf(_tokenId) == msg.sender
            || VetRegistry(_vetRegistry).isVet(msg.sender)
            || ShelterRegistry(_shelterRegistry).isShelter(msg.sender)
        );
        _;
    }

    constructor(address initialOwner, address vetRegistry, address shelterRegistry)
        ERC721("PetOwnership", "PET")
        Ownable(initialOwner)
    {
        setVetRegistry(vetRegistry);
        setShelterRegistry(shelterRegistry);
    }

    function safeMint(address _to, string calldata _ipfsHash) external {
        uint256 _tokenId = _nextTokenId++;
        _safeMint(_to, _tokenId);
        _setTokenURI(_tokenId, string.concat("ipfs://", _ipfsHash));
        emit PetOwnershipMinted(_to, _tokenId);
    }

    function updateTokenURI(uint256  _tokenId, string calldata _ipfsHash) external isTokenOwner(_tokenId) {
        _setTokenURI(_tokenId, string.concat("ipfs://", _ipfsHash));
        emit PetOwnershipURIUpdated(_tokenId, _ipfsHash);
    }

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }

    function getVetRegistry() external view returns (address) {
        return _vetRegistry;
    }

    function setVetRegistry(address _address) public onlyOwner {
        require(_vetRegistry != _address);
        _vetRegistry = _address;
    }

    function getShelterRegistry() external view returns (address) {
        return _shelterRegistry;
    }

    function setShelterRegistry(address _address) public onlyOwner {
        require(_shelterRegistry != _address);
        _shelterRegistry = _address;
    }
}
