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
}