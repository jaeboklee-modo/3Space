pragma solidity 0.5.6;

import "@openzeppelin/contracts/token/ERC721/ERC721Full.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721MetadataMintable.sol";
import "@openzeppelin/contracts/drafts/Counters.sol";

contract ThreeSpace is ERC721Full, ERC721MetadataMintable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    event Paint(address to);

    constructor() ERC721Full("3SPACE ART", "SPACE") public {
    }

    function paint(address to, string memory tokenURI) public returns (bool) {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();

        mintWithTokenURI(to, newItemId, tokenURI);

        emit Paint(to);
        return true;
    }
}