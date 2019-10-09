pragma solidity ^0.4.24;

import './Ownable.sol';

/**
 * @title ERC721 Non-Fungible Token Standard basic implementation
 * @dev see https://github.com/ethereum/EIPs/blob/master/EIPS/eip-721.md
 */
contract KatCoin is Ownable {

  // @dev This event is emitted whenever a new KatCoin is minted
  event Minted(address owner, uint256 katId, uint256 genes);

  // @dev This event is emitted when a kat has been sent
  event Sent(address from, address to, uint256 katId);

  struct Kat {
    uint32 color;
    uint16 generation;
  }

  Kat[] kats;

  // Mapping from kat ID to owner
  mapping (uint256 => address) private _katOwner;

  // Mapping from owner to number of owned KatCoins
  mapping (address => uint256) private _ownedKatsCount;

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
    return _ownedKatsCount[owner];
  }

  /**
   * @dev Gets the owner of the specified kat ID
   * @param katId uint256 ID of the kat to query the owner of
   * @return owner address currently marked as the owner of the given kat ID
   */
  function ownerOf(uint256 katId) public view returns (address) {
    address owner = _katOwner[katId];
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
    require(address(this) == _katOwner[katId]);
    _transferFrom(address(this), msg.sender, katId);
    owner.transfer(msg.value);
  }

  function _transferFrom(address from, address to, uint256 katId) internal {
    require(from == _katOwner[katId]);
    require(to != address(0));

    _removeKatFrom(from, katId);
    _addKatTo(to, katId);

    emit Sent(from, to, katId);
  }

  /**
   * @dev Internal function to mint a new kat
   * Reverts if the given kat ID already exists
   * @param to The address that will own the minted kat
   * @param katId uint256 ID of the kat to be minted by the msg.sender
   */
  function _mint(address to, uint256 katId, uint256 genes) internal {
    require(to != address(0));
    _addKatTo(to, katId);
    emit Minted(to, katId, genes);
  }

  /**
   * @dev Internal function to add a kat ID to the list of a given address
   * @param to address representing the new owner of the given kat ID
   * @param katId uint256 ID of the kat to be added to the kats list of the given address
   */
  function _addKatTo(address to, uint256 katId) internal {
    require(_katOwner[katId] == address(0));
    _katOwner[katId] = to;
    _ownedKatsCount[to]++;
  }

  /**
   * @dev Internal function to remove a kat ID from the list of a given address
   * @param from address representing the previous owner of the given kat ID
   * @param katId uint256 ID of the kat to be removed from the kats list of the given address
   */
  function _removeKatFrom(address from, uint256 katId) internal {
    require(ownerOf(katId) == from);
    _ownedKatsCount[from]--;
    _katOwner[katId] = address(0);
  }
}
