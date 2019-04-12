# Micro Slots

## What
Storing and accessing multiple integer values, using only one single uint256 slot.

## Why
Applications pay for storage on a slot by slot basis.
A single uint256 data slot can store any value between 0 and 115792089237316195423570985008687907853269984665640564039457584007913129639935 and as such it may be feasable to create a pattern which obeys a certain convention which ultimately allows many application variables to be stored in one single slot.

## How
The following is an example of how certain slices of data can be accessed individually.
This is a design which can be implemented in any language which supports modulo arithmetic and exponentiation (i.e. Python and even Solidity). 

## Function logic(psuedo code) to obtain any digit[s] from a uint256
```
((_value % (10 ** _position)) - (_value % (10 ** (_position - _size)))) / (10 ** (_position - _size));
```

Here are the descriptions for the pattern's arguments

## Function arguments(inputs)
- _value
is the big integer (uint256) which has a range from `0` to `2**256-1` 
- _position
is the single digit position (from within _value) from where you would like to begin the extraction
- _size
is the amount of digits which you would like to extract from _value

Here is an example of the pattern, written in solidity
```
contract uintTool {
    function getInt(uint256 _value, uint256 _position, uint256 _size) public pure returns(uint256){
        uint256 a = ((_value % (10 ** _position)) - (_value % (10 ** (_position - _size)))) / (10 ** (_position - _size));
        return a;
    }
}
```
## Reading example

Using the following fictitious value (_value = 20190404002345671103045555602345605676) the following points are true:
- _position 2 and _size 2 
will return 76
- _position 15 and _size 3 
will return 555
- _position 38 and _size 4 
will return 2019
- _position 34 and _size 2 
will return 04
- _position 32 and _size 2 
will return 04
- _position 38 and _size 19 
will return the left half (2019040400234567110) of this particular _value
- _position 19 and _size 19 
will return the right half (3045555602345605676) of this particular _value
