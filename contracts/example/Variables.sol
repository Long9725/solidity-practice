pragma solidity ^0.5.11;

contract WorkingWithVariables {
    /*
        값을 설정하지 않으면 기본 값으로 설정된다.
        정의되지 않은 값이나 null 값을 얻을 수 없다.
    */
    uint256 public myUint;
    bool public myBool; 
    /*
        uint는 뒤에 붙는 숫자에 따라 2^n만큼의 양수를 표현할 수 있다.
        만약 0보다 작게 된다면 다시 (2^n - 1)로 이동한다.
        이 경우에는 어떠한 경고도 없기 때문에, 조심히 다루어야 한다.
    */
    uint8 public myUint8;
    address public myAddress;
    /*
        문자열 연결, 검색 불가
        문자열 대체할 함수 X
        내부적으로 바이트 배열로 저장, UTF-8로 다시 변환
        문자열로 작업하는 건 Gas fee가 꽤 비싸다.
        따라서 문자열을 블록체인 외부에 저장하고, 일치하는 지만 검사하는 스킬을 자주 사용한다.
    */
    string public myString = "Hello, world!";

    function setMyUint(uint _myUint) public {
        myUint = _myUint;
    }

    function setMyBool(bool _myBool) public {
        myBool = _myBool;
    }

    function incrementUint() public {
        myUint8++;
    }

    function decrementUint() public {
        myUint8--;
    }

    function setAddress(address _address) public {
        myAddress = _address;
    }    

    /*
        view는 읽기 전용 함수이다.
        어떤 타입의 변수를 return 할 것인지 정의한다.
    */
    function getBalanceOfAddress() public view returns(uint) {
        return myAddress.balance;
    }

    /*
        이 인수는 스토리지 변수가 아니라 메모리에 저장 될 것임을 알려준다.
        Gas fee가 훨씬 싸다.
    */
    function setMyString(string memory _myString) public {
        myString = _myString;
    }
}