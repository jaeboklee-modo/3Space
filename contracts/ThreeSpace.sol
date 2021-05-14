pragma solidity ^0.5.0;

import "@openzeppelin/contracts/token/ERC721/ERC721Full.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721MetadataMintable.sol";
import "@openzeppelin/contracts/drafts/Counters.sol";

contract ThreeSpace is ERC721Full, ERC721MetadataMintable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    event Paint(
        address indexed to,
        uint256 tokenId,
        string artist,
        string title);

    mapping (uint256 => string) public artist;

    mapping (uint256 => string) public title;

    constructor() ERC721Full("3SPACE ART", "SPACE") public {
        _setBaseURI("http://3space.art/");
    }

    function paint(
        address to,
        string memory tokenURI,
        string memory artist_,
        string memory title_
    ) public returns (bool) {

        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();

        mintWithTokenURI(to, newItemId, tokenURI);

        _setArtworkInformation(newItemId, artist_, title_);

        emit Paint(to, newItemId, artist_, title_);
        return true;
    }

    function _setArtworkInformation(
        uint256 id,
        string memory artist_,
        string memory title_
    ) internal {
        artist[id] = artist_;
        title[id] = title_;
    }

    function setMainPage(
        string memory newBaseURI
    ) public onlyMinter {
        _setBaseURI(newBaseURI);
    }

    function changeArtworkInformation(
        uint256 id,
        string memory tokenURI,
        string memory artist_,
        string memory title_
    ) public onlyMinter {
        _setArtworkInformation(id, artist_, title_);
        _setTokenURI(id, tokenURI);
    }
}