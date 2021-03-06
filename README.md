# Micro Slots

## What

Storing and accessing multiple integer values, using only one single uint256 slot.

## Why

Applications pay for storage on a slot by slot basis.
A single uint256 data slot can store any value between 0 and 115792089237316195423570985008687907853269984665640564039457584007913129639935 and as such it may be feasable to create a pattern which obeys a certain convention which ultimately allows many application variables to be stored in one single slot.

## How

The following is an example of how certain slices of data can be accessed individually.
This is a design which can be implemented in any language which supports modulo arithmetic and exponentiation (i.e. Python and even Solidity). 

Based on the assumption that we would want to store any combination of numbers from zero to nine (0 to 9) anywhere inside the single uint256 variable. The upper bound of uint256 is 
```
115792089237316195423570985008687907853269984665640564039457584007913129639935
```
and therefore the digit on the far left could only ever contain a zero or a one. This might actually come in handy as a flag. There are a total of 78 digits in the upper bound of the uint256 data type and as such the digit on the far left could be accessed as follows.

```
uint256 big = 115792089237316195423570985008687907853269984665640564039457584007913129639935
getInt(big, 78, 1)
```

**Aside from the digit on the far left, there are 77 remaining digits** which can be programmed to have their value set to between zero and nine (0 to 9). One way to prove that there are in fact 77 (0 to 9) digits available, is to execute the following Python3 script which returns the largest possible value of uint256 where all digits equal 9. Warning this test takes a considerable amount of time. Results are posted below.

```
big = 115792089237316195423570985008687907853269984665640564039457584007913129639935


for char in str(big):
    if char != '9':
        big = big - 1
        break

print (str(big))
print (len(str(big)))
```

The results from the above test script are as follows.

```
99999999999999999999999999999999999999999999999999999999999999999999999999999
77
```
There are 77 (0 to 9) digits available in this single uint256 slot. So how do we access each of them, or sets of them, individually?

# Get integer

## getInt function pseudo code

```
((_value % (10 ** _position)) - (_value % (10 ** (_position - _size)))) / (10 ** (_position - _size));
```

Here are the descriptions for the pattern's arguments

## getInt function arguments(inputs)

- _value
is the big integer (uint256) which has a range from `0` to `2**256-1` 
- _position
is the single digit position (from within _value) from where you would like to begin the extraction
- _size
is the amount of digits which you would like to extract from _value

## getInt written in Solidity

Here is an example of the above pseudo code, written in solidity
```
contract uintTool {
    function getInt(uint256 _value, uint256 _position, uint256 _size) public pure returns(uint256){
        uint256 a = ((_value % (10 ** _position)) - (_value % (10 ** (_position - _size)))) / (10 ** (_position - _size));
        return a;
    }
}
```

## getInt written in Vyper

```
@public
@constant
def getInt(_value: uint256, _position: uint256, _size: uint256) -> uint256:
    a: uint256 = ((_value % (10 ** _position)) - (_value % (10 ** (_position - _size)))) / (10 ** (_position - _size))
    return a
```
## getInt output examples

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

# Zero-out a single value

## zeroOutSingleValue function pseudo code

To zero-out a value you would use the following design pattern.

```
_value - (_value % (10 ** _position) - (_value % (10 ** (_position - 1))))
```

## zeroOutSingleValue function in Solidity

```
function zeroOutSingleValue(uint256 _value, uint256 _position) public pure returns(uint256){
    uint256 b = _value - (_value % (10 ** _position) - (_value % (10 ** (_position - 1))));
    return b;
}
```

## zeroOutSingleValue output examples

Using the following fictitious value (_value = 1234) the following points are true:
- _position 2 would return 1204
- _position 3 would return 1034

# Zero-out many values 

## zeroOutManyValues pseudo code

To zero-out one or more values at a time, use the following design pattern.

```
((_value % (10 ** _position)) - (_value % (10 ** (_position - _size)))) / (10 ** (_position - _size))
```

## zeroOutManyValues in Solidity

```
function zeroOutManyValues(uint256 _value, uint256 _position, uint256 _size) public pure returns(uint256){
    uint256 c = _value - ((_value % (10 ** _position)) - (_value % (10 ** (_position - _size))));
    return c;
}
```

## zeroOutManyValues output examples

Using the following fictitious value (_value = 12345) the following points are true:
- _position 3 and _size 2 would return 12005
- _position 4 and _size 2 would return 10045
- _position 5 and _size 5 would return 00000

# Update single value

## updateSingleValue function pseudo code

To update a value you would use the following design pattern.

```
_value + _newInt * (10 ** (_position - 1))
```

## updateSingleValue function in Solidity

``` 
function updateSingleValue(uint256 _value, uint256 _newInt, uint256 _position)public pure returns(uint256){
    uint256 c = _value + _newInt * (10 ** (_position - 1));
    return c;
}
```

## updateSingleValue output examples

Using the following fictitious value (_value = 12305) the following points are true:
- _newInt 4 and _position 2 would return 12345
- _newInt 5 and _position 2 would return 12355

# Update many values

## updateManyValues function pseudo code

To update multiple digits you would use the following design.

```
_value + (_newInt * 10 ** (_position - 2))
```

## updateManyValues function in Solidity

```
function updateManyValues(uint256 _value, uint256 _newInt, uint256 _position) public pure returns(uint256){
    uint256 e = _value + (_newInt * 10 ** (_position - 2));
    return e;
}
```

## updateManyValues output examples

Using the following fictitious value (_value = 1004567) the following points are true:
- _newInt 23 and _position 6 would return 1234567
- _newInt 99 and _position 6 would return 1994567

# Additional information

## Overall efficiency for usage

We mentioned above that there is 1 zero to one (0 to 1) digit and 77 zero to nine (o to 9) digits available in a single uint256 slot. The factors of 77 are **1, 7, 11 and 77** and as such the following combinations offer the most efficient storage with the least amount of waste.

* 1, 77 digit integer with an individual value between 0 and 99999999999999999999999999999999999999999999999999999999999999999999999999999
* 77, 1 digit integers with an individual value between 0 and 9
* 7, 11 digit integers with an individual value between 0 and 99999999999
* 11, 7 digit integers with an individual value between 0 and 9999999

