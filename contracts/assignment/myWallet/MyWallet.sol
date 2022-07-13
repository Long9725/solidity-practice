pragma solidity 0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

import "./Owned.sol";

/*
    1. 입금은 누구나 가능하다.
    2. Owner는 자금을 무제한 인출 가능하다.
    3. Non-owner는 특정 주소의 특정 금액만 인출 가능하다.
    4. Owner만 Non-owner의 접근 권한을 바꿀 수 있다.
*/

contract MyWallet is Owned {

    using SafeMath for uint;

    mapping(address => uint) public Balances;

    event DepositEvent(address _addr, uint _amount);
    event WithdrawEvent(address _addr, uint _amount);

    function getSmartContractBalance() public view returns(uint) {
        return address(this).balance;
    }

    function deposit(uint _amount) public payable {
        require(address(msg.sender).balance >= _amount, "Not enough ether");
        Balances[msg.sender] = Balances[msg.sender].add(_amount);

        emit DepositEvent(msg.sender, _amount);
    }

    function withdrawalTo(address payable _to, uint _amount) public payable {
        require(Balances[msg.sender] >= _amount, "Not enough ether");
        Balances[msg.sender] =  Balances[msg.sender].sub(_amount);
        Balances[_to] =   Balances[_to].add(_amount);

        emit WithdrawEvent(msg.sender, _amount);
        emit DepositEvent(_to, _amount);

        _to.transfer(Balances[msg.sender]);
    }

    receive() external payable {
        deposit(msg.value);
    }

    fallback () external {
        
    }
}