// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721, IERC721, IERC721Metadata} from '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import {ERC721Burnable} from '@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol';
import {ERC721Enumerable} from '@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol';
import {AccessControl} from '@openzeppelin/contracts/access/AccessControl.sol';
import './ItemsLib.sol';

contract CosmikBattleBackCards is ERC721, ERC721Enumerable, ERC721Burnable, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256('MINTER_ROLE');
    string private _uri;
    mapping(uint32 => uint64) public typeIdCount;

    event SetBaseURI(string newURI);
    event Minted(
        address indexed to,
        uint256 indexed seed,
        uint32 indexed typeId,
        uint160 itemAttributes,
        uint256 tokenId
    );

    constructor(address manager) ERC721('Cosmik Back Cards', 'cBCards') {
        _grantRole(DEFAULT_ADMIN_ROLE, manager);
    }

    function setURI(string memory newURI) external onlyRole(DEFAULT_ADMIN_ROLE) {
        _setURI(newURI);
    }

    function _setURI(string memory newURI) private {
        _uri = newURI;
        emit SetBaseURI(newURI);
    }

    function _baseURI() internal view override returns (string memory) {
        return _uri;
    }

    function mint(address to, uint160 itemAttributes, uint32 typeId, uint256 seed) external onlyRole(MINTER_ROLE) {
        uint64 typeCount = typeIdCount[typeId] += 1;
        uint256 tokenId = ItemsLib.computeItemId(typeId, itemAttributes, typeCount);
        _mint(to, tokenId);
        emit Minted(to, seed, typeId, itemAttributes, tokenId);
    }

    // The following functions are overrides required by Solidity.

    function _update(
        address to,
        uint256 tokenId,
        address auth
    ) internal override(ERC721, ERC721Enumerable) returns (address) {
        return super._update(to, tokenId, auth);
    }

    function _increaseBalance(address account, uint128 value) internal override(ERC721, ERC721Enumerable) {
        super._increaseBalance(account, value);
    }

    function supportsInterface(
        bytes4 interfaceId
    ) public view virtual override(AccessControl, ERC721, ERC721Enumerable) returns (bool) {
        return
            interfaceId == type(IERC721).interfaceId ||
            interfaceId == type(IERC721Metadata).interfaceId ||
            interfaceId == type(ERC721Enumerable).interfaceId ||
            super.supportsInterface(interfaceId);
    }
}
