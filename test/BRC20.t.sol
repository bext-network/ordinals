// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {BRC20} from "../src/BRC20.sol";


contract BRC20Test is Test {

    address constant MANAGER_ADDRESS = 0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496;

    BRC20 public brc20;

    function setUp() public {
        brc20 = new BRC20("ordi", 1_000, 21_000_000, 18, MANAGER_ADDRESS);
    }

    function test_Mint() public {
        brc20.mint("bc1pxaneaf3w4d27hl2y93fuft2xk6m4u3wc4rafevc6slgd7f5tq2dqyfgy06", 1000, "24f2585e667e345c7b72a4969b4c70eb0e2106727d876217497c6cf86a8a354ci0");
        assertEq(brc20.balances("bc1pxaneaf3w4d27hl2y93fuft2xk6m4u3wc4rafevc6slgd7f5tq2dqyfgy06"), 1000_000000000000000000);
        assertEq(brc20.totalSupply(),  1000_000000000000000000);
    }

    function test_Inscribe() public {
        brc20.mint("bc1pxaneaf3w4d27hl2y93fuft2xk6m4u3wc4rafevc6slgd7f5tq2dqyfgy06", 1000, "24f2585e667e345c7b72a4969b4c70eb0e2106727d876217497c6cf86a8a354ci0");
        brc20.inscribe("bc1pxaneaf3w4d27hl2y93fuft2xk6m4u3wc4rafevc6slgd7f5tq2dqyfgy06", 100, "885441055c7bb5d1c54863e33f5c3a06e5a14cc4749cb61a9b3ff1dbe52a5bbbi0");

        assertEq(brc20.balances("bc1pxaneaf3w4d27hl2y93fuft2xk6m4u3wc4rafevc6slgd7f5tq2dqyfgy06"), 1000_000000000000000000);
        assertEq(brc20.transferableBalances("bc1pxaneaf3w4d27hl2y93fuft2xk6m4u3wc4rafevc6slgd7f5tq2dqyfgy06"), 100_000000000000000000);
        assertEq(brc20.transferables("bc1pxaneaf3w4d27hl2y93fuft2xk6m4u3wc4rafevc6slgd7f5tq2dqyfgy06", "885441055c7bb5d1c54863e33f5c3a06e5a14cc4749cb61a9b3ff1dbe52a5bbbi0"), 100_000000000000000000);
    }

    function test_Transfer() public {
        brc20.mint("bc1pxaneaf3w4d27hl2y93fuft2xk6m4u3wc4rafevc6slgd7f5tq2dqyfgy06", 1000, "24f2585e667e345c7b72a4969b4c70eb0e2106727d876217497c6cf86a8a354ci0");
        brc20.inscribe("bc1pxaneaf3w4d27hl2y93fuft2xk6m4u3wc4rafevc6slgd7f5tq2dqyfgy06", 100, "885441055c7bb5d1c54863e33f5c3a06e5a14cc4749cb61a9b3ff1dbe52a5bbbi0");

        brc20.transfer("bc1pxaneaf3w4d27hl2y93fuft2xk6m4u3wc4rafevc6slgd7f5tq2dqyfgy06", "1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa", "885441055c7bb5d1c54863e33f5c3a06e5a14cc4749cb61a9b3ff1dbe52a5bbbi0");

        assertEq(brc20.balances("bc1pxaneaf3w4d27hl2y93fuft2xk6m4u3wc4rafevc6slgd7f5tq2dqyfgy06"), 1000_000000000000000000 - 100_000000000000000000);
        assertEq(brc20.balances("1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa"), 100_000000000000000000);
        assertEq(brc20.transferableBalances("bc1pxaneaf3w4d27hl2y93fuft2xk6m4u3wc4rafevc6slgd7f5tq2dqyfgy06"), 0);
        assertEq(brc20.transferables("bc1pxaneaf3w4d27hl2y93fuft2xk6m4u3wc4rafevc6slgd7f5tq2dqyfgy06", "885441055c7bb5d1c54863e33f5c3a06e5a14cc4749cb61a9b3ff1dbe52a5bbbi0"), 0);
    }

}
