pragma solidity >=0.5.15 < 0.7.0;

contract A {
    uint someUint;

    /*
        함수가 virtual 키워드로 표시되거나, 인터페이스에 정의된 경우에만 재정의할 수 있다.
        인터페이스 외부 실행이 불가능한 함수는 virtual로 표시해야 한다.

        함수나 제어자를 재정의할 때는 override로 표시해야 한다. 
    */
    function fun() public virtual {
        someUint = 5;
    }
}