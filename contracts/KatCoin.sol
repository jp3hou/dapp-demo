pragma solidity ^0.4.24;

import './Ownable.sol';

/**
 * @title ERC721 Non-Fungible Token Standard basic implementation
 * @dev see https://github.com/ethereum/EIPs/blob/master/EIPS/eip-721.md
 */
contract KatCoin is Ownable {

  // @dev This event is emitted whenever a new KatCoin is minted
  event Minted(address owner, uint256 katId, uint256 genes);

  // @dev This event is emitted when a token has been sent
  event Sent(address from, address to, uint256 tokenId);

  struct Kat {
    uint32 color;
    uint16 generation;
  }

  Kat[] kats;

  // Mapping from token ID to owner
  mapping (uint256 => address) private _tokenOwner;

  // Mapping from owner to number of owned KatCoins
  mapping (address => uint256) private _ownedTokensCount;

  // Minting 30 KatCoins upon the initialization of this contract
  // (For the purposes of this demonstration only)
  constructor() public {
    for (uint32 i = 0; i < 30; i++) {
      kats.push(Kat((i + 3) * 32, 0));
      _mint(address(this), kats.length - 1, i * 32);
    }
  }

  /**
   * @dev Gets the balance of the specified address
   * @param owner address to query the balance of
   * @return uint256 representing the amount owned by the passed address
   */
  function balanceOf(address owner) public view returns (uint256) {
    require(owner != address(0));
    return _ownedTokensCount[owner];
  }

  /**
   * @dev Gets the owner of the specified token ID
   * @param tokenId uint256 ID of the token to query the owner of
   * @return owner address currently marked as the owner of the given token ID
   */
  function ownerOf(uint256 tokenId) public view returns (address) {
    address owner = _tokenOwner[tokenId];
    require(owner != address(0));
    return owner;
  }

  function getKat(uint256 katId) public view returns (uint32 color, uint16 generation) {
    Kat storage kat = kats[katId];

    color = kat.color;
    generation = kat.generation;
  }

  function purchase(uint256 katId) public payable {
    require(katId >= 0);
    require(katId < 30);
    require(address(this) == _tokenOwner[katId]);
    require(msg.value >= 200 finney);
    _transferFrom(address(this), msg.sender, katId);
    owner.transfer(msg.value);
  }

  function _transferFrom(address from, address to, uint256 tokenId) internal {
    require(from == _tokenOwner[tokenId]);
    require(to != address(0));

    _removeTokenFrom(from, tokenId);
    _addTokenTo(to, tokenId);

    emit Sent(from, to, tokenId);
  }

  /**
   * @dev Internal function to mint a new token
   * Reverts if the given token ID already exists
   * @param to The address that will own the minted token
   * @param tokenId uint256 ID of the token to be minted by the msg.sender
   */
  function _mint(address to, uint256 tokenId, uint256 genes) internal {
    require(to != address(0));
    _addTokenTo(to, tokenId);
    emit Minted(to, tokenId, genes);
  }

  /**
   * @dev Internal function to add a token ID to the list of a given address
   * @param to address representing the new owner of the given token ID
   * @param tokenId uint256 ID of the token to be added to the tokens list of the given address
   */
  function _addTokenTo(address to, uint256 tokenId) internal {
    require(_tokenOwner[tokenId] == address(0));
    _tokenOwner[tokenId] = to;
    _ownedTokensCount[to]++;
  }

  /**
   * @dev Internal function to remove a token ID from the list of a given address
   * @param from address representing the previous owner of the given token ID
   * @param tokenId uint256 ID of the token to be removed from the tokens list of the given address
   */
  function _removeTokenFrom(address from, uint256 tokenId) internal {
    require(ownerOf(tokenId) == from);
    _ownedTokensCount[from]--;
    _tokenOwner[tokenId] = address(0);
  }
}
