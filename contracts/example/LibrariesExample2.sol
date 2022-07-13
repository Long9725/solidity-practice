pragma solidity ^0.5.11;

/*
    Library는 contract처럼 사용한다. 하지만 contract와 달리 state가 없기 때문에, destroy는 불가능하다.
    DELEGATECALL이라는 것을 사용할 수 있는데, 특정 주소에 배포된 다른 스마트 계약 또는 일부 EDM 코드를 호출하기 위해 사용하는 함수이다.
    Library 내의 코드는 contract의 상태 안에서 실행되기 때문에, 이러한 상태를 알기 위해서 호출하는 함수인 것 같다.

    1. 상태가 없다.
    2. 상속이 불가능하다.
    3. Ether를 받을 수 없다.
*/
library Search {
    function indexOf(uint[] storage self, uint value) public view returns (uint) {
        for (uint i = 0; i < self.length; i++) if(self[i] == value) return i;
        // uint에는 -1이 max of uint이다. Solidity 0.8.0 이상에서는 -1이 안 되는 것으로 확인했다.
        return uint(-1);
    }
}

contract NotUsingForExample {
    uint[] data;
    
    function append(uint value) public {
        data.push(value);
    }

    function replace(uint _old, uint _new) public {
        uint index = Search.indexOf(data, _old);
        if (index == uint(-1)) data.push(_new);
        else data[index] = _new;
    }
}

contract UsingForExample {
    using Search for uint[];
    uint[] data;
    
    function append(uint value) public {
        data.push(value);
    }

    function replace(uint _old, uint _new) public {
        uint index = data.indexOf(_old);
        if (index == uint(-1)) data.push(_new);
        else data[index] = _new;
    }
}

