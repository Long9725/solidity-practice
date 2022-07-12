pragma solidity ^0.8.0;

/*
    이번 예제는 OpenZeppelin의 SafeMath가 Solidty 0.8 버전 이상에서 작성되어서 실행되지 않는다.
    낮은 버전의 SafeMath를 찾거나, Solidity 버전을 높여야한다. unchecked가 Solidity 0.5.11에는 없는 것 같다.

*/

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

contract LibrariesExample {
    
    using SafeMath for uint;

    mapping(address => uint) public tokenBalance;

    constructor() public  {
        tokenBalance[msg.sender] = 1;
    }

    function sendToken(address _to, uint _amount) public returns(bool) {
        tokenBalance[msg.sender] = tokenBalance[msg.sender].sub(_amount);
        tokenBalance[_to] = tokenBalance[_to].add(_amount);

        return true;
    }
}
