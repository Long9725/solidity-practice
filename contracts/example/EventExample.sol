pragma solidity ^0.5.11;

/*
    실제 네트워크에서 하는 것과 자바스크립트 VM을 사용해서 하는 것은 decoded output 결과가 달라진다.
    event를 사용하면 log를 확인할 수 있다.
*/

contract EventExample {

    mapping(address => uint) public tokenBalance;

    /* 
        event는 대문자로 시작한다. CapWords 스타일이라고 한다.
        다음의 용도로 사용한다.

        1. 함수가 트리거되거나 트랜잭션이 채굴될 때, 특정 값을 반환해야 할 경우
        2. 트리거 기능
        3. 저렴한 데이터 저장소 : 이벤트는 사이트 체인에 저장된 데이터를 내보낼 수 있는데, Storage 변수의 String에 저장하는 것보다 싸다.

        실제 블록체인에서는 return 값을 사용할 수 없기 때문이다.
        트랜잭션을 실행하면 트랜잭션은 트랜잭션 해시를 반환한다.
        이 트랜잭션이 채굴되기 전에 오류, 성공, 롤백 등 몇 가지 다른 상태가 발생할 수 있다.
        이벤트는 이렇게 어떠한 일이 있었는지 사용자에게 알리고, return 값을 사용할 수 있게끔 한다.
        이를 표준 이벤트 트리거라고 한다.

        한편 이더리움 블록체인에 데이터를 저장하는 것은 매우 많은 비용이 들기 때문에, 다음과 같은 방법이 있다.

        1. off-chain에 데이터를 저장하고, 해시 체인을 활용한다.
        2. IPFS와 같은 다른 블록체인에 데이터를 저장한다.
        3. String만 있어 Solidity code가 필요하지 않으면, 이벤트 로그에 데이터를 저장한다.

        event는 Solidity 내부에서 쓸 수 없고, 외부에서 쓸 수 있다. 
        event는 상속이 가능하다. index를 통해 event를 검색할 수 있다.
        따라서 스마트 컨트랙트 내부에 string이나 저렴한 정보를 저장해야 할 때에는 event를 사용할 수 없다.
    */
    event TokensSent(address _from, address _to, uint _amount);

    constructor() public {
        tokenBalance[msg.sender] = 100;
    }

    function sendToken(address _to, uint _amount) public returns(bool) {
        require(tokenBalance[msg.sender] >= _amount, "Not enough tokens");
        assert(tokenBalance[_to] + _amount >= tokenBalance[_to]);
        assert(tokenBalance[msg.sender] - _amount <= tokenBalance[msg.sender]);
        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_to] += _amount;

        emit TokensSent(msg.sender, _to, _amount);

        return true;
    }
}