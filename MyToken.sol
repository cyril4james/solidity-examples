// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v4.8/contracts/token/ERC20/ERC20.sol';

contract MyToken is ERC20 {
    constructor() ERC20("My Token","MTN") {
        _mint(msg.sender, 10000 * 10 ** 18);
    }
}
