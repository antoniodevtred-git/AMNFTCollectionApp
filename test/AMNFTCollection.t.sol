// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "../lib/forge-std/src/Test.sol";
import "../src/AMNFTCollection.sol";

contract AMNFTMintOnlyTest is Test {
    BANFTMintOnly c;

    address user1 = makeAddr("user1");
    address user2 = makeAddr("user2");

    string constant NAME = "BANFT";
    string constant SYMBOL = "BANFT";
    uint256 constant MAX_SUPPLY = 2;
    string constant BASE = "https://example.com/meta/";

    event Minted(address indexed to, uint256 indexed tokenId);

    function setUp() public {
        c = new BANFTMintOnly(NAME, SYMBOL, MAX_SUPPLY, BASE);
    }

    function test_DeployOk() public {
        assertEq(c.name(), NAME);
        assertEq(c.symbol(), SYMBOL);
        assertEq(c.maxSupply(), MAX_SUPPLY);
        assertEq(c.currentTokenId(), 0);
    }

    function test_Mint_IncrementsAndSetsOwner() public {
        vm.prank(user1);
        vm.expectEmit(true, true, false, true);
        emit Minted(user1, 0);
        c.mint();

        assertEq(c.currentTokenId(), 1);
        assertEq(c.ownerOf(0), user1);
        assertEq(c.tokenURI(0), string.concat(BASE, "0.json"));
    }

    function test_MultipleMintsUntilSoldOut() public {
        // user1 mintea id 0
        vm.prank(user1);
        c.mint();
        // user2 mintea id 1
        vm.prank(user2);
        c.mint();

        assertEq(c.currentTokenId(), 2); // sold out

        // tercer mint debe fallar
        vm.prank(user1);
        vm.expectRevert(bytes("Sold out"));
        c.mint();
    }

    function test_SameUserCanMintTwice_WhileSupplyAllows() public {
        // Como no hay límite por wallet, un usuario puede mintear varias veces hasta agotar supply
        vm.startPrank(user1);
        c.mint(); // id 0
        c.mint(); // id 1
        vm.stopPrank();

        assertEq(c.balanceOf(user1), 2);
        assertEq(c.currentTokenId(), 2);

        vm.prank(user1);
        vm.expectRevert(bytes("Sold out"));
        c.mint();
    }

    function test_TokenURI_RevertsIfNotMinted() public {
        vm.expectRevert(); // _requireOwned
        c.tokenURI(0);
    }
}
