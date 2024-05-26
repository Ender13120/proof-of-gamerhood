// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^4.0.0
pragma solidity ^0.8.0;

// Importing from GitHub repository for OpenZeppelin
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract GamerhoodBadge is ERC721, Ownable {
    using Strings for uint256;

    uint256 private _nextTokenId;
    mapping(uint256 => uint256) public tokenTimestamps;
    mapping(uint256 => bool) private _soulboundTokens;

    // Event to log the minting of tokens with their future timestamps
    event TokenMinted(uint256 tokenId, uint256 timestamp);
    event Soulbound(uint256 tokenId, bool status);
    event ExpiryRefreshed(uint256 tokenId, uint256 newExpiry);

    constructor()
        ERC721("Gamerhood Badge", "POG")
    {}

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _nextTokenId++;
        uint256 timestamp = block.timestamp + 30 days;
        tokenTimestamps[tokenId] = timestamp;
        _safeMint(to, tokenId);
        _soulboundTokens[tokenId] = true; // Make the token soulbound
        emit TokenMinted(tokenId, timestamp);
        emit Soulbound(tokenId, true);
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0
            ? string(abi.encodePacked(baseURI, tokenId.toString()))
            : "";
    }

    // Override of the base URI method
    function _baseURI() internal view virtual override returns (string memory) {
        return "https://api.example.com/token/";
    }



    // Refresh the expiry time for a token
    function refreshExpiry(uint256 tokenId) public onlyOwner {
        require(_exists(tokenId), "Token does not exist");
        uint256 newExpiry = block.timestamp + 30 days;
        tokenTimestamps[tokenId] = newExpiry;
        emit ExpiryRefreshed(tokenId, newExpiry);
    }

    // Override of the transfer function to enforce soulbound status
    function _update(address from, address to, uint256 tokenId) internal override(ERC721){
        require(!_soulboundTokens[tokenId] || from == address(0), "Token is soulbound");
        super._update(from, to, tokenId);
    }
}