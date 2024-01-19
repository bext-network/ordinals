// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.20;


import {IERC165} from "openzeppelin-contracts/contracts/utils/introspection/IERC165.sol";

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IBRC20 is IERC165 {

    event Deploy(string tick, uint256 limit, uint256 max, uint256 decimals);

    event Mint(string to, uint256 amount);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(string from, string to, uint256 value);

    event InscribeTransfer(string owner, uint256 value, string inscription);

    /**
     * @dev Returns the value of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the value of tokens owned by `account`.
     */
    function balanceOf(string memory account) external view returns (uint256);


    function mint(string memory to, uint256 value, string memory inscription) external returns (bool);

    /**
     * @dev Moves a `value` amount of tokens from the `spender`'s account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(string memory spender, string memory to, string memory inscription) external returns (bool);

    /**
     * @dev Sets a `value` amount of tokens as the inscribe of `spender` over the
     * caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits an {InscribeTransfer} event.
     */
    function inscribe(string memory spender, uint256 value, string memory inscription) external returns (bool);

}
