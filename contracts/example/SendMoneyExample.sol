pragma solidity ^0.5.11;

contract SendMoneyExample {

    uint public balanceReceived;
    /*
        payable은 컴파일러가 이 함수로 돈을 받는다는 것을 인식하게 해준다.
        Solidity에는 항상, 트랜잭션이 진행되는 동안에도 사용할 수 있는 msg라는 글로벌 오브젝트가 존재한다.
    */
    function receiveMoney() public payable {
        // msg.value에는 Wei 단위로 저장되어 있다.
        balanceReceived += msg.value;
    }

    /*
        address를 테스트하고, balance를 가져온다.
    */
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function withdrawMoney() public {
        address payable to = msg.sender;

        to.transfer(this.getBalance());
    }

    function withdrawMoneyTo(address payable _to) public {
        _to.transfer(this.getBalance());
    }
}