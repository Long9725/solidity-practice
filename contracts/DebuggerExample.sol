pragma solidity ^0.5.11;

/*
    ABI : Application Binary Interface

    ABI Array는 스마트 계약의 주소 옆에 있다. Json file이다.
    ABI Array에는 스마트 계약과 상호작용하는 데 필요한 모든 것이 포함된다.
    스마트 컨트랙트는 이진 코드일 뿐이다.
*/

/*
    스마트 컨트랙트 배포 또는 수명 주기
    
    1. Solidity에서 스마트 계약을 생성하고 고급 코드를 작성한다. (어셈블리 사용 가능)
    2. 코드를 Byte code로 컴파일한다. 더 이상 일반 텍스트 함수로 표시되지 않고, 함수 서명으로 표기된다.
    3. 함수 서명값과 트랜잭션의 데이터 필드 값을 비교한다.

    Remix에서는 필드 버튼을 누르면 상호작용할 수 있다. 
    실제로는 데이터 필드를 통해 낮은 레벨에서 이루어지지만, 리믹스 라이브러리가 대신 한다.
    해시를 계산한 다음 올바른 해시로 트랜잭션을 보내는 것이다.
*/

/*
    함수 서명

    함수 해시는 함수 서명의 keccak256 해시의 첫 4바이트이다.
    즉 bytes4(keccak256(,,myUint()""));이다.

    function someFunction(uint _myUint1, address _someAddr)이라는 함수가 있다고 하자.
    이 경우에는 함수 서명은 someFunction(uint,address)이고, 함수 해시는 bytes4(keccak256(,,someFunction(uint,address)"))이다.

    특정 저수준 라이브러리를 작성하지 않는 한, 건드릴 일은 잘 없다.
*/

/*
    디버거는 프로토타입에 사용하기 좋지만, 일반적으로 생각하는 상용화된 컴파일러 수준은 아니다.
    하지만 스마트 계약을 작성하는데는 충분하다. 스마트 계약은 크기가 작아야 하기 때문이다.
    크면 나의 문제인가..?!
*/
contract DebuggerExample {
    uint public myUint;

    function setMyUint(uint _myUint) public {
        myUint = _myUint;
    }
}