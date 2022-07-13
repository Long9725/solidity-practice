pragma solidity ^0.5.11;

/*
    스마트 컨트랙트의 Life-cycle은 다음과 같다.
    1. Deploy   
    2. Interact
    3. Destory/Stop
*/
contract StartStopUpdateExample {
    address owner;

    bool public paused;

    constructor() public {
        owner = msg.sender;
    }

    function setPaused(bool _paused) public {
        require(msg.sender == owner, "You are not the owner");
        paused = _paused;
    }

    function sendMoney() public payable {

    }

    function withdrawAllMoney(address payable _to) public {
        /*
            if(msg.sender == owner) {
                _to.transfer(address(this).balance);
            } else {
                new Exception();
            }

            위 코드와 같은 역할을 한다.
            트랜잭션은 원자성을 가지기 때문에, 실패하면 트랜잭션은 멈추거나 롤백한다. 이 경우, 블록체인에 반영되지 않는다.
        */
        require(msg.sender == owner, "You are not the owner");
        require(!paused, "Contract is paused");
         _to.transfer(address(this).balance);
    }

    function destroySmartContract(address payable _to) public {
        require(msg.sender == owner, "You are not the owenr");
        /*
            스마트 컨트랙트를 상태에서 제거하기
            그런데 sendMoney는 실행이 된다.
        */
        selfdestruct(_to);
    }
}