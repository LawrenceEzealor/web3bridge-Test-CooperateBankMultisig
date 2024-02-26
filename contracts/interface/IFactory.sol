// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

import "../Banking.sol";

interface IFactory {
    function createMultiCooperateBank(
        address _tokenAddress,
        address[] memory _members,
        uint8 _signers
    ) external returns (CooperateBank newBank_, uint256 length_);

    function getMultiCooperateBank()
        external
        view
        returns (CooperateBank[] memory);
}
