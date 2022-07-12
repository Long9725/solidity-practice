/*
    works in 0.6.0
*/

pragma solidity 0.6.0;

contract A {
    event SomeEvent(address _addr, uint _amount);

    receive() external payable {
        emit SomeEvent(msg.sender, msg.value);
    }

    // msg.data가 비지 않았거나 receive()가 없을 때 호출된다.
    fallback() external {

    }
}