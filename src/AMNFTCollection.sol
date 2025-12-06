// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "../lib/openzeppelin-contracts/contracts/utils/Strings.sol";

contract AMNFTCollection is ERC721 {
    using Strings for uint256;

    uint256 public currentTokenId; 
    uint256 public immutable maxSupply;
    string public baseUri;

    event Minted(address indexed to, uint256 indexed tokenId);

    constructor(string memory name_, string memory symbol_, uint256 maxSupply_, string memory baseUri_) ERC721(name_, symbol_) {
        require(maxSupply_ > 0, "maxSupply = 0");
        maxSupply = maxSupply_;
        baseUri = baseUri_;
    }

    function mint() external {
        require(currentTokenId < maxSupply, "Sold out");

        uint256 newId = currentTokenId;
        _safeMint(msg.sender, newId);

        emit Minted(msg.sender, newId);
        unchecked { currentTokenId++; }
    }

    function _baseURI() internal view override returns (string memory) {
        return baseUri;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        _requireOwned(tokenId);
        string memory b = _baseURI();
        return bytes(b).length > 0 ? string.concat(b, tokenId.toString(), ".json") : "";
    }
}
