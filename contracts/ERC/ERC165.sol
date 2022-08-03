// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

interface IERC165 {
    function supportsInterface(bytes4 interfaceId) external view returns(bool);
}

contract ERC165 is IERC165 {
    mapping(bytes4 => bool) private _supportedInterfaces;

    constructor() {
        _registerInterface(0x01ffc9a7);
    }

    function calcFingerPrint() public pure returns(bytes4) {
        return bytes4(keccak256('supportsInterface(bytes4)'));
    }

    function supportsInterface(bytes4 interfaceId) external override view returns(bool) {
        return _supportedInterfaces[interfaceId];
    }

    function _registerInterface(bytes4 interfaceId) public {
        require(interfaceId != 0xffffffff, "ERC165: invalid interface");
        _supportedInterfaces[interfaceId] = true;
    }
}