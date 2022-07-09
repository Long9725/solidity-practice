pragma solidity ^0.5.11;

contract FunctionExample {
    
    mapping(address => uint) public balanceReceived;

    address payable owner;

    constructor() public {
        owner = msg.sender;
    }

    /*
        view function는 읽기 전용으로, write function을 호출할 수 없다.
    */
    function getOwner() public view returns(address) {
        return owner;
    }

    /*
        pure function는 storage 변수와 상호작용하지 않는다.
        storage 변수는 스마트 계약의 특정 상태를 저장하는 변수이다.
        다르게 말하면 클래스 변수라고 칭한다.
        pure function는 다른 view나 write function을 호출할 수 없다.
    */
    function convertWeiToEther(uint _amountInWei) public pure returns(uint) {
        return _amountInWei / 1 ether;
    }

    function destroySmartContract() public {
        require(msg.sender == owner, "You are not the owner");
        selfdestruct(owner);
    }

    function receiveMoney() public payable {
        assert(balanceReceived[msg.sender] + msg.value >= balanceReceived[msg.sender]);
        balanceReceived[msg.sender] += msg.value;
    }

    function withdrawMoney(address payable _to, uint _amount) public {
        require(_amount <= balanceReceived[msg.sender], "Not enough funds");
        assert(balanceReceived[msg.sender] >= balanceReceived[msg.sender] - _amount);
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
    
    /*
        Fallback 함수, 함수 사용 없이 스마트 컨트랙트로 돈을 보낼 수 있다.
        기술적인 해결책이다. 근데 왜 안 보일까..?
    */
    function () external payable {
        receiveMoney();
    }
}