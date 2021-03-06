pragma solidity 0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Allowance is Ownable { 
    using SafeMath for uint;

    event AllwanceChanged(address indexed _forWho, address indexed _fromWhom, uint _oldAmount, uint _newAmount);

    mapping(address => uint) public allowance;

    function isOwner() internal view returns(bool) {
        return owner() == _msgSender();
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function addAllowance(address _who, uint _amount) public onlyOwner {
        emit AllwanceChanged(_who, msg.sender, allowance[_who], _amount);
        allowance[_who] = _amount;
    }

    modifier ownerOrAllowed(uint _amount) {
        require(isOwner() || allowance[msg.sender] >= _amount, "You are not allowed");
        _;
    }

    function reduceAllowance(address _who, uint _amount) internal {
        emit AllwanceChanged(_who, msg.sender, allowance[_who], allowance[_who] - _amount);
        allowance[_who] = allowance[_who].sub(_amount);
    }
}