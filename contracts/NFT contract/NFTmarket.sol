// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTMarketplace is ERC721URIStorage, Ownable {
    struct NFT {
        uint256 tokenId;
        address payable owner;
        uint256 price;
        bool isListed;
    }

    uint256 public nextTokenId;
    mapping(uint256 => NFT) public nfts;

    event NFTMinted(uint256 tokenId, address owner, string tokenURI);
    event NFTListed(uint256 tokenId, uint256 price);
    event NFTUnlisted(uint256 tokenId);
    event NFTBought(uint256 tokenId, address buyer, uint256 price);

constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {}
    /**
     * @notice Mint a new NFT
     * @param _tokenURI Metadata URI for the NFT
     */
    function mintNFT(string memory _tokenURI, uint256 _price) public {
        require(_tokenURI, "Token URI is required");
        require(_price > 0, "Price must be greater than zero");

        uint256 tokenId = nextTokenId;
        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, _tokenURI);

        nfts[tokenId] = NFT(tokenId, payable(msg.sender), _price, true);
        nextTokenId++;

        emit NFTMinted(tokenId, msg.sender, _tokenURI);
    }

    /**
     * @notice List an NFT for sale
     * @param _tokenId ID of the NFT to list
     * @param _price Sale price in wei
     */
    function listNFT(uint256 _tokenId, uint256 _price) public {
        require(ownerOf(_tokenId) == msg.sender, "Only the owner can list the NFT");
        require(_price > 0, "Price must be greater than zero");

        NFT storage nft = nfts[_tokenId];
        nft.price = _price;
        nft.isListed = true;

        emit NFTListed(_tokenId, _price);
    }

    /**
     * @notice Unlist an NFT from sale
     * @param _tokenId ID of the NFT to unlist
     */
    function unlistNFT(uint256 _tokenId) public {
        require(ownerOf(_tokenId) == msg.sender, "Only the owner can unlist the NFT");

        NFT storage nft = nfts[_tokenId];
        nft.isListed = false;

        emit NFTUnlisted(_tokenId);
    }

    /**
     * @notice Buy a listed NFT
     * @param _tokenId ID of the NFT to buy
     */
    function buyNFT(uint256 _tokenId) public payable {
        NFT storage nft = nfts[_tokenId];
        require(nft.isListed, "NFT is not listed for sale");
        require(msg.value == nft.price, "Incorrect price sent");

        address payable seller = nft.owner;

        // Transfer ownership of the NFT
        nft.owner = payable(msg.sender);
        nft.isListed = false;
        nft.price = 0;
        _transfer(seller, msg.sender, _tokenId);

        // Transfer payment to the seller
        seller.transfer(msg.value);

        emit NFTBought(_tokenId, msg.sender, msg.value);
    }
}
