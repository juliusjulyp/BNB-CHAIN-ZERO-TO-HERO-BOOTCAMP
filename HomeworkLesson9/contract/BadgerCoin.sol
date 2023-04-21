// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BadgerCoin is ERC20, Ownable{
constructor()ERC20 ("BadgerCoin", "BC"){
_mint(msg.sender, 1000000 * 10**decimals());
}


    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}
 

 // 0x36acd8fa9eb4a86185f2c0a2483e24a5e93b5159