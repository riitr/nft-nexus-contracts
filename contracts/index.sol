// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/common/ERC2981.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract NFTMarketplace is ERC721URIStorage, ERC2981, Ownable, ReentrancyGuard {
    uint256 private _tokenIds;
    IERC20 public paymentToken;
    uint256 public marketplaceFee = 250; // 2.5% fee (250/10000)
    address public feeRecipient;

    struct ListedNFT {
        uint256 tokenId;
        uint256 price;
        address seller;
        bool isListed;
    }

    mapping(uint256 => ListedNFT) public listings;

    event NFTMinted(uint256 tokenId, address owner, string tokenURI);
    event NFTListed(uint256 tokenId, uint256 price, address seller);
    event NFTSold(uint256 tokenId, address buyer);
    event NFTDelisted(uint256 tokenId, address seller);

    constructor(address _paymentToken, address _feeRecipient) ERC721("NFT Marketplace", "NFTM") Ownable(msg.sender) {
        paymentToken = IERC20(_paymentToken);
        feeRecipient = _feeRecipient;
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC721URIStorage, ERC2981) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function mintNFT(string memory tokenURI, uint96 royaltyFee) public returns (uint256) {
        _tokenIds++;
        uint256 newTokenId = _tokenIds;
        _mint(msg.sender, newTokenId);
        _setTokenURI(newTokenId, tokenURI);
        _setTokenRoyalty(newTokenId, msg.sender, royaltyFee);
        emit NFTMinted(newTokenId, msg.sender, tokenURI);
        return newTokenId;
    }

    function listNFT(uint256 tokenId, uint256 price) public {
        require(ownerOf(tokenId) == msg.sender, "You do not own this NFT");
        require(price > 0, "Price must be greater than zero");

        listings[tokenId] = ListedNFT(tokenId, price, msg.sender, true);
        emit NFTListed(tokenId, price, msg.sender);
    }

    function delistNFT(uint256 tokenId) public {
        require(listings[tokenId].seller == msg.sender, "You are not the seller");
        require(listings[tokenId].isListed, "NFT is not listed");

        listings[tokenId].isListed = false;
        emit NFTDelisted(tokenId, msg.sender);
    }

    function buyNFT(uint256 tokenId) public nonReentrant {
        ListedNFT storage listing = listings[tokenId];
        require(listing.isListed, "NFT is not for sale");

        uint256 feeAmount = (listing.price * marketplaceFee) / 10000;
        uint256 sellerAmount = listing.price - feeAmount;

        require(paymentToken.transferFrom(msg.sender, feeRecipient, feeAmount), "Fee payment failed");
        require(paymentToken.transferFrom(msg.sender, listing.seller, sellerAmount), "Seller payment failed");

        _transfer(listing.seller, msg.sender, tokenId);
        listing.isListed = false;

        emit NFTSold(tokenId, msg.sender);
    }

    function setMarketplaceFee(uint256 _fee) external onlyOwner {
        require(_fee <= 1000, "Fee cannot exceed 10%");
        marketplaceFee = _fee;
    }
}
