// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {ERC165} from "openzeppelin-contracts/contracts/utils/introspection/ERC165.sol";

import {IBRC20} from "./interfaces/IBRC20.sol";

contract BRC20 is ERC165, IBRC20 {
    address public manager;

    string public tick;

    uint8 public immutable decimals;

    uint256 public limit;
    uint256 public max;

    uint256 public totalSupply;

    mapping(string account => uint256) public balances;

    mapping(string account => uint256) public transferableBalances;

    mapping(string account => mapping(string inscription => uint256)) public transferables;

    mapping(string inscription => bool) public inscriptionList;


    modifier onlyManager() {
        require(manager == msg.sender, "BRC20: only manager");
        _;
    }

    modifier checkInscription(string memory _inscriptionId) {
        require(!inscriptionList[_inscriptionId], "BRC20: inscription exist");
        inscriptionList[_inscriptionId] = true;
        _;
    }

    constructor(string memory _tick, uint256 _limit, uint256 _max, uint8 _decimals, address _manager) {
        tick = _tick;

        decimals = _decimals;
        limit = _limit * (10 ** decimals);
        max = _max * (10 ** decimals);

        manager = _manager;

        emit Deploy(_tick, limit, max, _decimals);
    }

    function balanceOf(string memory _account) public view virtual returns (uint256) {
        return balances[_account];
    }

    function mint(string memory _to, uint256 _value, string memory _inscriptionId) external onlyManager checkInscription(_inscriptionId) returns (bool)  {
        uint256 value = _value * (10 ** decimals);
        if (value == 0 || value > limit) {
            return false;
        }
        if (value + totalSupply > max) {
            return false;
        }
        totalSupply += value;
        balances[_to] += value;

        emit Mint(_to, value);

        return true;
    }

    function inscribe(string memory _spender, uint256 _value, string memory _inscriptionId) external onlyManager checkInscription(_inscriptionId) returns (bool) {
        uint256 value = _value * (10 ** decimals);

        if (_value == 0) {
            return false;
        }

        if (balances[_spender] < value) {
            return false;
        }

        if (transferableBalances[_spender] + value > balances[_spender]) {
            return false;
        }

        transferableBalances[_spender] += value;

        transferables[_spender][_inscriptionId] = value;

        emit InscribeTransfer(_spender, value, _inscriptionId);

        return true;
    }

    function transfer(string memory _spender, string memory _to, string memory _inscriptionId) external onlyManager returns (bool) {
        uint256 value = transferables[_spender][_inscriptionId];
        if (value == 0) {
            return false;
        }

        balances[_to] += value;
        balances[_spender] -= value;
        transferableBalances[_spender] -= value;

        delete transferables[_spender][_inscriptionId];

        emit Transfer(_spender, _to, value);

        return true;
    }
}
