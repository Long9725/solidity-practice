pragma solidity ^0.5.11;

contract Owned {
    address owner;

    constructor() public {
        owner = msg.sender;
    }
    
    /*
        제어자.
        밑줄 부분에 해당 제어자를 사용하는 함수 본문을 복사해온다.
        그리고 제어자의 내용을 포함하여 다시 해당 함수로 복사한다.
    */
    modifier onlyOwner() {
        require(msg.sender == owner, "You are not allowed");
        _;
    }

}