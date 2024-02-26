// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

import "./Banking.sol";

contract MultiSigFactory {
    CooperateBank[] cooperateBankClones;

    function createMultiCooperateBank(
        address _tokenAddress,
        address[] memory _members,
        uint8 _signers
    ) external returns (CooperateBank newBank_, uint256 length_) {
        newBank_ = new CooperateBank(_tokenAddress, _members, _signers);

        cooperateBankClones.push(newBank_);

        length_ = cooperateBankClones.length;
    }

    function getMultiCooperateBank()
        external
        view
        returns (CooperateBank[] memory)
    {
        return cooperateBankClones;
    }
}
