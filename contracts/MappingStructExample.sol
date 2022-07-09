pragma solidity ^0.5.11;

contract MappingStructExample {

    /*
        객체 지향 프로그래밍에서처럼 struct를 contract로 나눌 수 있다.
        하지만 struct에 비해서 Gas가 많이 필요로 한다.
        따라서 주로 이러한 방식으로 사용하고, 외부 스토리지로 컨트랙트를 분리하고 싶을 때 사용한다.
        Struct는 자기 자신을 재귀적으로 가질 수 없다.
    */
    struct Payment {
        uint amount;
        uint timestamps;
    }

    struct Balance {
        uint totolBalance;
        uint numPayments;
        mapping(uint => Payment) payments;
    }

    /*
        Solidity에도 배열은 있다. 역시나 Gas가 많이 필요로 해서 주로 Mapping을 쓴다.
        Mapping은 길이 정보가 없으므로, 길이를 활용하자면 길이 정보를 따로 저장하거나 라이브러리를 사용해야한다.
        Mapping은 Hash-Map처럼 동작한다.
    */

    mapping(address => Balance) public balanceReceived;

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function sendMoney() public payable {
        balanceReceived[msg.sender].totolBalance += msg.value;

        // 참조 변수이기 떄문에 memory를 사용한다는데, 알아보자.
        Payment memory payment = Payment(msg.value, now);

        balanceReceived[msg.sender].payments[balanceReceived[msg.sender].numPayments] = payment;
        balanceReceived[msg.sender].numPayments++;
    }

    function withdrawMoney(address payable _to, uint _amount) public {
        require(balanceReceived[msg.sender].totolBalance >= _amount, "Not enough funds");
        balanceReceived[msg.sender].totolBalance -= _amount;
        _to.transfer(_amount);
    } 

    function withdrawAllMoney(address payable _to) public {
        uint balanceToSend = balanceReceived[msg.sender].totolBalance;
        balanceReceived[msg.sender].totolBalance = 0;
        _to.transfer(balanceToSend);
    }
}