pragma solidity ^0.5.0;

// Define the `JointSavings` contract
contract JointSavings {
    // Declare state variables
    address payable public accountOne;
    address payable public accountTwo;
    address public lastToWithdraw;
    uint public lastWithdrawAmount;
    uint public contractBalance;

    // Function to withdraw funds from the joint savings account
    function withdraw(uint amount, address payable recipient) public {
        // Verify the recipient is either accountOne or accountTwo
        require(
            recipient == accountOne || recipient == accountTwo,
            "You don't own this account!"
        );

        // Verify the contract has enough funds for the withdrawal
        require(
            address(this).balance >= amount,
            "Insufficient funds!"
        );

        // If recipient is different from the last one to withdraw, update lastToWithdraw
        if (lastToWithdraw != recipient) {
            lastToWithdraw = recipient;
        }

        // Transfer the specified amount to the recipient
        recipient.transfer(amount);

        // Update lastWithdrawAmount and contractBalance
        lastWithdrawAmount = amount;
        contractBalance = address(this).balance;
    }

    // Function to deposit funds into the contract
    function deposit() public payable {
        // Update contractBalance to reflect the current balance of the contract
        contractBalance = address(this).balance;
    }

    // Function to set the accounts authorized to withdraw from this contract
    function setAccounts(address payable account1, address payable account2) public {
        accountOne = account1;
        accountTwo = account2;
    }

    // Fallback function to accept Ether deposits without data
    function() external payable {
        // Automatically called when the contract receives Ether
    }
}

