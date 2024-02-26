// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

import "./interface/IToken.sol";

contract CooperateBank {
    address TokenAddress;

    uint256 allAmount;

    uint counts;

    address[] members;
    uint8 signers;

    struct Transactions {
        uint id;
        address creator;
        uint amount;
        bool isApproved;
        uint signersCount;
    }

    constructor(
        address _tokenAddress,
        address[] memory _members,
        uint8 _signers
    ) {
        TokenAddress = _tokenAddress;
        signers = _signers;

        for (uint8 i = 0; i < _members.length; i++) {
            require(_members[i] != address(0), "no zero address");
            isValidMember[_members[i]] = true;
        }
        members = _members;
    }

    mapping(address => bool) isValidMember;
    mapping(uint => Transactions) transactions;
    mapping(address => bool) hasSigned;

    Transactions[] allTransactions;

    function deposit(uint _amount) external {
        require(msg.sender != address(0), "no address zero");

        require(_amount > 0, "no zero amount");

        require(
            IToken(TokenAddress).balanceOf(msg.sender) >= _amount,
            "insufficient fund"
        );

        require(
            IToken(TokenAddress).transferFrom(
                msg.sender,
                address(this),
                _amount
            ),
            "failed transaction"
        );

        allAmount = allAmount + _amount;
    }

    function initiateWithdrawal(uint256 _amount) external {
        require(msg.sender != address(0), "you are not a valid member");
        require(_amount > 0, "zero amount cant be withdrawn");
        require(isValidMember[msg.sender], "sorry, youre not a valid member");
        // require(
        //     IToken(TokenAddress).balanceOf(address(this)) >= _amount,
        //     "NO funds to withdraw"
        // );

        require(allAmount >= _amount, "Insufficient funds to withdraw");

        uint _id = counts + 1;

        Transactions storage newTx = transactions[_id];

        newTx.id = _id;
        newTx.amount = _amount;
        newTx.creator = msg.sender;
        newTx.signersCount = newTx.signersCount + 1;

        hasSigned[msg.sender] = true;

        allTransactions.push(newTx);

        counts++;
    }

    function approvedTransaction(uint _id) external returns (bool) {
        require(_id <= counts, "counts limit reached");

        require(isValidMember[msg.sender], "not authorized");

        require(!hasSigned[msg.sender], "cant sign twice");

        Transactions storage Tx = transactions[_id];

        require(!Tx.isApproved, "transaction already approved");

        Tx.signersCount++;

        if (Tx.signersCount == signers) {
            IToken(TokenAddress).transfer(Tx.creator, Tx.amount);
        }

        return Tx.isApproved = true;
    }

    //create a function to get all transaction
    function getAllTransactions()
        external
        view
        returns (Transactions[] memory)
    {
        return allTransactions;
    }
}
