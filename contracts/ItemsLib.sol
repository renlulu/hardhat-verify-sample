// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

/*
 * @title ItemsLib
 * @notice ItemsLib can be used to manipulate item ids. Format is:
 *  Attributes<160> | itemType<32> | randomness<64>
 *
 * itemType also contain information about rarity :
 * unused<8> | rarity<4> | index<20>
 *
 * rarity is encoded as follow
 * 0b0001 : common
 * 0b0010 : uncommon
 * 0b0100 : rare
 * 0b1000 : common
 *
 * index is a number that is used to differentiate each itemType.
 */
library ItemsLib {
    struct Token {
        address token;
        uint256 amount;
    }

    uint256 public constant ITEMTYPE_SIZE = 32;
    uint256 public constant SEED_SIZE = 64;
    uint256 public constant ATTRIBUTES_SIZE = 160;
    uint256 public constant ATTRIBUTES_OFFSET = 96;

    uint256 public constant MAX_ITEMTYPE = (2 ** ITEMTYPE_SIZE) - 1;
    uint256 public constant MAX_ATTRIBUTES = (2 ** ATTRIBUTES_SIZE) - 1;
    uint256 public constant MAX_SEED = (2 ** SEED_SIZE) - 1;

    function getItemType(uint256 itemId) internal pure returns (uint32) {
        return uint32((itemId >> SEED_SIZE) & MAX_ITEMTYPE);
    }

    function getItemAttribute(uint256 itemId) internal pure returns (uint160) {
        return uint160((itemId >> ATTRIBUTES_OFFSET) & MAX_ATTRIBUTES);
    }

    function getSeed(uint256 itemId) internal pure returns (uint64) {
        return uint64(itemId & MAX_SEED);
    }

    function computeItemId(uint32 itemType, uint160 itemAttributes, uint256 seed) internal pure returns (uint256) {
        return (uint256(itemAttributes) << ATTRIBUTES_OFFSET) | (uint256(itemType) << SEED_SIZE) | (seed & MAX_SEED);
    }
}
