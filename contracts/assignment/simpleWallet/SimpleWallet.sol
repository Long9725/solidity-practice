pragma solidity 0.8.0;

import './Allowance.sol';

contract SimpleWallet is Allowance {

    event MoneySent(address indexed _beneficiary, uint indexed _amount);
    event MoneyReceive(address indexed _from, uint indexed _amount);

    function withdrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount) {
        require(address(this).balance >= _amount, "There are not enough funds stored in the smart contract");
        if(!isOwner()) {
            reduceAllowance(msg.sender, _amount);
        }
        MoneySent(_to, _amount);

        _to.transfer(_amount);
    }

    /*
        public, view, onlyOwner와 같은 함수의 키워드 순서는 상관없다. 
    */
    function renounceOwnership() public view override(Ownable) onlyOwner {
        revert("Can't renouce ownership here.");
    }

    receive() external payable {
        emit MoneyReceive(msg.sender, msg.value);
    }

    fallback () external {
        
    }
}