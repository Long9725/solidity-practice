/*
    works in 0.5.15
*/

// pragma solidity 0.5.15;

// contract A {
//     event MyEvent(string _myString);
//     function funA() public {
//         emit MyEvent("from A");
//     }
// }

// contract B {
//     function funA() public {
//         // does nothing
//     }
// }

// /*
//     1. contract C is A, B는 A 재정의 이후 B를 재정의 하므로, super.funA()는 아무것도 하지 않아야 한다.
//     2. contract C is B, A는 B 재정의 이후 A를 재정의 하므로, super.funA()는 from A를 출력한다.
// */
// contract C is A, B {
//     function funA() public {
//         emit MyEvent("from B");
//         super.funA();
//     }
// }

/*
    works in 0.6.0
*/

pragma solidity 0.6.0;

contract A {
    event MyEvent(string _myString);
    function funA() public virtual {
        emit MyEvent("from A");
    }
}

contract B {
    function funA() public virtual {
        // does nothing
    }
}

/*
    0.5.15와 똑같다. override(A,B)는 상관없는 것 같다.
*/
contract C is B, A {
    function funA() public override(A,B) {
        emit MyEvent("from B");
        super.funA();
    }
}