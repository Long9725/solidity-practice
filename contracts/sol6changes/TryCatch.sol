pragma solidity 0.6.0;

contract ContractA {
    function funARequireFailure() public pure {
        require(false, "This is an error String");
    }

    function funBRevertFailure() public pure {
        revert("Error from Contract A");
    }

    function funCAssertFailure() public pure {
        assert(false);
    }
}

contract B {
    ContractA instA;

    event Error(string _reason);
    event LowLevelError(bytes _reason);

    constructor() public {
        instA = new ContractA();
    }

    function testRequireTryCatch() public returns(bool) {
        // try instA.funARequireFailure() {
        //     return true;
        // try instA.funBRevertFailure() {
        //     return true;
        try instA.funCAssertFailure() {
            return true;
        } catch Error(string memory reason) {
            /*
                revert
            */
            emit Error(reason);
            return false;
        } catch (bytes memory lowLevelData) {
            /*
                revert or failing assertion, division by zero 등
            */
            emit LowLevelError(lowLevelData);
            return false;
        }
    }
}