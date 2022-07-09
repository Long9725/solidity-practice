pragma solidity ^0.5.11;

contract FunctionExample {
    /*
        Function의 범위는 4가지이다.
        1. Public - 전부 공개
        2. Private - 해당 컨트랙트만 사용 가능
        3. External - 외부에서 호출 가능하지만, 해당 컨트랙트 내부에서 호출은 불가능
        4. Internal - 해당 컨트랙트 및 상호작용하는 컨트랙트

        Writing은 네트워크에 존재하는 모든 분산 노드에 블록체인 데이터가 존재해야 하기 때문에 가스를 요구한다.
        Reading은 네트워크에 존재하는 로컬 노드만으로도 읽을 수 있어 사실상 무료라고 한다.
    */
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
        항상 external이어야 한다.
        기술적인 해결책이다. Deploy 이후 Low level interations을 통해 사용할 수 있다.
    */
    function () external payable {
        receiveMoney();
    }

    /* 
        Solidity 0.6? 0.8? 업데이트 이후, Fallback 함수가 분리되었다.
        receive는 Ether를 받고 스마트 컨트랙트와 상호 작용한다.
        fallback은 Ether를 받지 않고 스마트 컨트랙트와 상호 작용한다.
    */
    // receive() external payable {
    //     receiveMoney();
    // }
}