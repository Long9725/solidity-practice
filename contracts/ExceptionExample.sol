pragma solidity ^0.5.11;

contract ExceptionExample{
    mapping(address => uint64) public balanceReceived;

    function receiveMoney() public payable {
        assert(msg.value == uint64(msg.value));
        balanceReceived[msg.sender] += uint64(msg.value);

        // 새로운 입력으로 인해 uint64 범위를 넘어가면, 잔고는 오히려 줄어들 것이다. 이를 막는다. 
        assert(balanceReceived[msg.sender] >= uint64(msg.value));
    }

    function withdrawMoney(address payable _to, uint64 _amount) public {
        /*
            둘 다 트랜잭션을 종료한다.
            require은 사용하지 않고 남은 가스는 사용자에게 반환된다. 고급 스타일에서 보통 발생한다. 낮은 수준에서는 assert가 발생한다.
            assert는 모든 가스를 소모한다. 따라서 정말 예상치 못한 일이 일어났을 때만 실행되어야 한다.
            특히 사용자의 입력값과 상관없이 말이다. 예를 들어 런타임 도중 out of array가 발생했을 때 실행된다.
            revert도 있는데, 이것은 거짓을 요구하는 것이다.

            require는 입력 유효성 검사에 사용하고, assert는 내부 상태나 불변량 검사에 사용한다.
        */

        /*
            if(_amount <= balanceReceived[msg.sender]) {
                revert("You don't have enough ether);
            }
            
            require(_amount <= balanceReceived[msg.sender], "You don't have enough ether");

            위 두 코드는 같은 코드이다.
        */

        require(_amount <= balanceReceived[msg.sender], "You don't have enough ether");
        assert(balanceReceived[msg.sender] >= balanceReceived[msg.sender] - _amount);
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
}