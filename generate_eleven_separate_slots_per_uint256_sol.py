# To run type the following command
# python3 generate_eleven_separate_slots_per_uint256_sol.py

stringOpen = "pragma solidity ^0.5.0;\ncontract MicroSlots {\n    uint256 private value = 100000000000000000000000000000000000000000000000000000000000000000000000000000;\n"
print(stringOpen)
stringFunctions = ""

# Read each slot explicitly without the need for any arguments
for i in range(1, 12):
	pos = i * 7;
	stringFunctions += "    function getPosition" + str(i) + "() public view returns(uint256){\n        return ((value % (10 ** " + str(pos) + ")) - (value % (10 ** (" + str(pos) + " - 7)))) / (10 ** (" + str(pos) + " - 7));\n    }\n"
	print(stringFunctions)
	stringFunctions = ""
stringClose = "}\n"
print(stringClose)
