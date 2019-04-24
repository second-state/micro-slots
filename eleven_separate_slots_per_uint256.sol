pragma solidity ^0.5.0;

// The following contract uses a fixed convention which provides 11 unique micro-slots, each with 7 digits between 0 and 9.
// Each of the functions are designed to explicitly return the appropriate slot.
// Warning: This is a prototype for research purposes and it is not to be used to transact real value yet.

contract MicroSlots{

// This variable must be set to 77 digits between 0 and 9
uint256 private value = 76543210000000000000000000000000000000000055555554444444333333322222221111111;

// TODO This contract needs modifiers which will only allow numbers between 1 and 9999999 to be set for each position


// Returns 1111111
function getPosition1() public view returns(uint256){
    return ((value % (10 ** 7)) - (value % (10 ** (7 - 7)))) / (10 ** (7 - 7));
}

// Returns 2222222
function getPosition2() public view returns(uint256){
    return ((value % (10 ** 14)) - (value % (10 ** (14 - 7)))) / (10 ** (14 - 7));
}

// Returns 3333333
function getPosition3() public view returns(uint256){
    return ((value % (10 ** 21)) - (value % (10 ** (21 - 7)))) / (10 ** (21 - 7));
}

//Returns 4444444
function getPosition4() public view returns(uint256){
    return ((value % (10 ** 28)) - (value % (10 ** (28 - 7)))) / (10 ** (28 - 7));
}

// Returns 5555555
function getPosition5() public view returns(uint256){
    return ((value % (10 ** 35)) - (value % (10 ** (35 - 7)))) / (10 ** (35 - 7));
}

// Returns 0000000
function getPosition6() public view returns(uint256){
    return ((value % (10 ** 42)) - (value % (10 ** (42 - 7)))) / (10 ** (42 - 7));
}

// Returns 0000000
function getPosition7() public view returns(uint256){
    return ((value % (10 ** 49)) - (value % (10 ** (49 - 7)))) / (10 ** (49 - 7));
}

// Returns 0000000
function getPosition8() public view returns(uint256){
    return ((value % (10 ** 56)) - (value % (10 ** (56 - 7)))) / (10 ** (56 - 7));
}

// Returns 0000000
function getPosition9() public view returns(uint256){
    return ((value % (10 ** 63)) - (value % (10 ** (63 - 7)))) / (10 ** (63 - 7));
}

// Returns 0000000
function getPosition10() public view returns(uint256){
    return ((value % (10 ** 70)) - (value % (10 ** (70 - 7)))) / (10 ** (70 - 7));
}

// Returns 7654321
function getPosition11() public view returns(uint256){
    return ((value % (10 ** 77)) - (value % (10 ** (77 - 7)))) / (10 ** (77 - 7));
}

}
