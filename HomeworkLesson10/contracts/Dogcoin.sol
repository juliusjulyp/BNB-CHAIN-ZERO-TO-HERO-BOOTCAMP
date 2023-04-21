// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.18;

contract DogCoin{
    uint256 totalSupply;
    address public owner;

    //best data structure to track user balances is mapping
    mapping (address => uint ) public balances;

    // a modifier that allows the owner to do important execution in the smartcontract
    modifier onlyOwner {
        require(msg.sender == owner, "not allowed, only owner can call this function");
        _;
    }

  //  a constructor to initialize the state of our contract
    constructor(){
        
        totalSupply = 2000000;
        owner = msg.sender;
        balances[owner] = totalSupply;
        
    }

    event Value(uint256 newValue );
    event TransferTookPlace(address, address, uint256);

    struct Payment{
        address recipient;
        uint256 amount;
    }

    mapping(address => Payment[]) public payments;

// a function that returns the total supply of our token
    function AllSupply() public view returns(uint256){
        
        return totalSupply;
    }


    //a function that increases the total in a thousand steps 
    function increamenter() public onlyOwner{
        totalSupply += 1000;
        emit Value(totalSupply);
    }

    function getBalance(address _address) public view returns(uint256){
        return balances[_address];
    }

    function transfer(uint256 transferAmount, address recipient) public{
        require(balances[msg.sender] >= transferAmount, "Insufficient funds in your account");
        balances[msg.sender] -= transferAmount;
        balances[recipient] += transferAmount;

        payments[msg.sender].push(Payment(recipient, transferAmount));

        emit TransferTookPlace(msg.sender, recipient, transferAmount);
    }


}












// pragma solidity ^0.8.9;

// // Uncomment this line to use console.log
// // import "hardhat/console.sol";

// contract Lock {
//     uint public unlockTime;
//     address payable public owner;

//     event Withdrawal(uint amount, uint when);

//     constructor(uint _unlockTime) payable {
//         require(
//             block.timestamp < _unlockTime,
//             "Unlock time should be in the future"
//         );

//         unlockTime = _unlockTime;
//         owner = payable(msg.sender);
//     }

//     function withdraw() public {
//         // Uncomment this line, and the import of "hardhat/console.sol", to print a log in your terminal
//         // console.log("Unlock time is %o and block timestamp is %o", unlockTime, block.timestamp);

//         require(block.timestamp >= unlockTime, "You can't withdraw yet");
//         require(msg.sender == owner, "You aren't the owner");

//         emit Withdrawal(address(this).balance, block.timestamp);

//         owner.transfer(address(this).balance);
//     }
// }
