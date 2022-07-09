pragma solidity ^0.5.11;

contract SimpleMappingExample {
    /*
        기본값으로 모두 초기화 된다.
        배열처럼 사용한다. 뭔가 딕셔너리 같기도 하고...?
        어디까지 저장할 수 있는거지?
    */
    mapping(uint => bool) public myMapping;
    mapping(address => bool) public myAddressMapping;

    function setValue(uint _index) public {
        myMapping[_index] = true;
    } 

    function setMyAddressToTrue() public {
        myAddressMapping[msg.sender] = true;
    }
}