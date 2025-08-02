// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }
}

contract QuantumWealthToken is ERC20Permit, ERC20Burnable, ERC20Pausable, Ownable {
    address public bridge;
    uint8 private constant _DECIMALS = 6;
    uint256 private constant _MAX_SUPPLY = 21000000 * 10 ** _DECIMALS;

     }

    function debridgeMint(address recipient, uint256 amount, bytes calldata signature) external {
        require(msg.sender == DEBRIDGE_GATE, "Unauthorized");
        require(!isBlacklisted[recipient], "Recipient blacklisted");
        bytes32 message = keccak256(abi.encodePacked(recipient, amount));
        address signer = recoverSigner(message, signature);
        require(signer == owner(), "Invalid signer");
        _mint(recipient, amount);
    }