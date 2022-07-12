/*
    works in 0.5.14
*/

pragma solidity 0.5.14;

contract A {
    uint x = 123;
}

contract B is A {
    uint x = 234;
}

/*
    works in 0.6.0
*/

// pragma solidity 0.6.0;

// contract A {
//     uint private x = 123;
// }

// contract B is A {
//     uint x = 234;
// }