pragma solidity ^0.5.0;
contract MicroSlots {
    uint256 private value = 100000000000000000000000000000000000000000000000000000000000000000000000000000;

    function getPosition1() public view returns(uint256){
        return ((value % (10 ** 7)) - (value % (10 ** (7 - 7)))) / (10 ** (7 - 7));
    }

    function getPosition2() public view returns(uint256){
        return ((value % (10 ** 14)) - (value % (10 ** (14 - 7)))) / (10 ** (14 - 7));
    }

    function getPosition3() public view returns(uint256){
        return ((value % (10 ** 21)) - (value % (10 ** (21 - 7)))) / (10 ** (21 - 7));
    }

    function getPosition4() public view returns(uint256){
        return ((value % (10 ** 28)) - (value % (10 ** (28 - 7)))) / (10 ** (28 - 7));
    }

    function getPosition5() public view returns(uint256){
        return ((value % (10 ** 35)) - (value % (10 ** (35 - 7)))) / (10 ** (35 - 7));
    }

    function getPosition6() public view returns(uint256){
        return ((value % (10 ** 42)) - (value % (10 ** (42 - 7)))) / (10 ** (42 - 7));
    }

    function getPosition7() public view returns(uint256){
        return ((value % (10 ** 49)) - (value % (10 ** (49 - 7)))) / (10 ** (49 - 7));
    }

    function getPosition8() public view returns(uint256){
        return ((value % (10 ** 56)) - (value % (10 ** (56 - 7)))) / (10 ** (56 - 7));
    }

    function getPosition9() public view returns(uint256){
        return ((value % (10 ** 63)) - (value % (10 ** (63 - 7)))) / (10 ** (63 - 7));
    }

    function getPosition10() public view returns(uint256){
        return ((value % (10 ** 70)) - (value % (10 ** (70 - 7)))) / (10 ** (70 - 7));
    }

    function getPosition11() public view returns(uint256){
        return ((value % (10 ** 77)) - (value % (10 ** (77 - 7)))) / (10 ** (77 - 7));
    }

}
