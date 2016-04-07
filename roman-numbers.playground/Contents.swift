//: Convert to and from Roman numerals
//: - [GitHub](https://github.com/HcomCoolCode/romans)
//: - [Stash](http://stash.hcom/users/mmatyjas/repos/romans/browse)

import Foundation


struct MapEntry {
    var romanNumerals: String
    var decimalValue: Int
    init(romanNumerals: String, decimalValue: Int) {
        self.romanNumerals = romanNumerals
        self.decimalValue = decimalValue
    }
}

let map = [
    [
        // Millions
        MapEntry(romanNumerals: "M̅",    decimalValue: 1000000),
    ],
    [   // Hundred Thousands
        MapEntry(romanNumerals: "C̅M̅",   decimalValue: 900000),
        MapEntry(romanNumerals: "D̅C̅C̅C̅", decimalValue: 800000),
        MapEntry(romanNumerals: "D̅C̅C̅",  decimalValue: 700000),
        MapEntry(romanNumerals: "D̅C̅",   decimalValue: 600000),
        MapEntry(romanNumerals: "D̅",    decimalValue: 500000),
        MapEntry(romanNumerals: "C̅D̅",   decimalValue: 400000),
        MapEntry(romanNumerals: "C̅C̅C̅",  decimalValue: 300000),
        MapEntry(romanNumerals: "C̅C̅",   decimalValue: 200000),
        MapEntry(romanNumerals: "C̅",    decimalValue: 100000),
    ],
    [   // Ten thousands
        MapEntry(romanNumerals: "X̅C̅",   decimalValue: 90000),
        MapEntry(romanNumerals: "L̅X̅X̅X̅", decimalValue: 80000),
        MapEntry(romanNumerals: "L̅X̅X̅",  decimalValue: 70000),
        MapEntry(romanNumerals: "L̅X̅",   decimalValue: 60000),
        MapEntry(romanNumerals: "L̅",    decimalValue: 50000),
        MapEntry(romanNumerals: "X̅L̅",   decimalValue: 40000),
        MapEntry(romanNumerals: "X̅X̅X̅X̅", decimalValue: 40000),
        MapEntry(romanNumerals: "X̅X̅X̅",  decimalValue: 30000),
        MapEntry(romanNumerals: "X̅X̅",   decimalValue: 20000),
        MapEntry(romanNumerals: "X̅",    decimalValue: 10000),
    ],
    [   // Thousands
        MapEntry(romanNumerals: "I̅X̅",   decimalValue: 9000),
        MapEntry(romanNumerals: "V̅I̅I̅I̅", decimalValue: 8000),
        MapEntry(romanNumerals: "V̅I̅I̅",  decimalValue: 7000),
        MapEntry(romanNumerals: "V̅I̅",   decimalValue: 6000),
        MapEntry(romanNumerals: "V̅",    decimalValue: 5000),
        MapEntry(romanNumerals: "I̅V̅",   decimalValue: 4000),
        MapEntry(romanNumerals: "MMMM", decimalValue: 4000),
        MapEntry(romanNumerals: "MV̅",   decimalValue: 4000),
        MapEntry(romanNumerals: "I̅I̅I̅I̅", decimalValue: 4000),
        MapEntry(romanNumerals: "MMM",  decimalValue: 3000),
        MapEntry(romanNumerals: "I̅I̅I̅",  decimalValue: 3000),
        MapEntry(romanNumerals: "MM",   decimalValue: 2000),
        MapEntry(romanNumerals: "I̅I̅",   decimalValue: 2000),
        MapEntry(romanNumerals: "M",    decimalValue: 1000),
        MapEntry(romanNumerals: "I̅",    decimalValue: 1000),
    ],
    [   // Hundreds
        MapEntry(romanNumerals: "CM",   decimalValue: 900),
        MapEntry(romanNumerals: "DCCC", decimalValue: 800),
        MapEntry(romanNumerals: "DCC",  decimalValue: 700),
        MapEntry(romanNumerals: "DC",   decimalValue: 600),
        MapEntry(romanNumerals: "D",    decimalValue: 500),
        MapEntry(romanNumerals: "CD",   decimalValue: 400),
        MapEntry(romanNumerals: "CCCC", decimalValue: 400),
        MapEntry(romanNumerals: "CCC",  decimalValue: 300),
        MapEntry(romanNumerals: "CC",   decimalValue: 200),
        MapEntry(romanNumerals: "C",    decimalValue: 100),
    ],
    [   // Tens
        MapEntry(romanNumerals: "XC",   decimalValue: 90),
        MapEntry(romanNumerals: "LXXX", decimalValue: 80),
        MapEntry(romanNumerals: "LXX",  decimalValue: 70),
        MapEntry(romanNumerals: "LX",   decimalValue: 60),
        MapEntry(romanNumerals: "L",    decimalValue: 50),
        MapEntry(romanNumerals: "XL",   decimalValue: 40),
        MapEntry(romanNumerals: "XXXX", decimalValue: 40),
        MapEntry(romanNumerals: "XXX",  decimalValue: 30),
        MapEntry(romanNumerals: "XX",   decimalValue: 20),
        MapEntry(romanNumerals: "X",    decimalValue: 10),
    ],
    [   // Units
        MapEntry(romanNumerals: "IX",   decimalValue: 9),
        MapEntry(romanNumerals: "VIII", decimalValue: 8),
        MapEntry(romanNumerals: "VII",  decimalValue: 7),
        MapEntry(romanNumerals: "VI",   decimalValue: 6),
        MapEntry(romanNumerals: "V",    decimalValue: 5),
        MapEntry(romanNumerals: "IV",   decimalValue: 4),
        MapEntry(romanNumerals: "IIII", decimalValue: 4),
        MapEntry(romanNumerals: "III",  decimalValue: 3),
        MapEntry(romanNumerals: "II",   decimalValue: 2),
        MapEntry(romanNumerals: "I",    decimalValue: 1),
    ]
]



func romanToNum(romanNumber: String) -> Int {
    
    var sum = 0
    var reducingRomanNumber = romanNumber
    
    for mapGroup in map {
        for mapEntry in mapGroup {
            if reducingRomanNumber.hasPrefix(mapEntry.romanNumerals) {
                sum = sum + mapEntry.decimalValue;
                reducingRomanNumber = reducingRomanNumber.substringFromIndex(mapEntry.romanNumerals.endIndex)
                break; // Break out of this mapGroup
            }
        }
    }
    
    if (reducingRomanNumber.characters.count > 0 || sum == 0) {
        return -1; // Invalid
    }
    
    return sum
}

func numToRoman(number: Int) -> String {
    
    var accumulatingRomanNumerals = ""
    var reducingNumber = number
    
    if (reducingNumber.description.characters.count > map.count) {
        return "invalid";
    }
    
    while reducingNumber > 0  {
        let reducingNumberLength = reducingNumber.description.characters.count
        let divider = Int(pow(Double(10), Double(reducingNumberLength-1))) // Gives us 1000 given number = 6788, 1 given 9, 100 given 356
        let valueToSum = (reducingNumber / divider) * divider // Will be 7000 for 7569, 400 for 409, 50 for 54, 3 for 3
        
        let mapGroup = map[map.count - reducingNumberLength]
        let romanNumerals = mapGroup.filter{$0.decimalValue == valueToSum}.first?.romanNumerals
        
        if (romanNumerals == nil) {
            return "invalid";
        }
        
        accumulatingRomanNumerals =  accumulatingRomanNumerals + romanNumerals!
        reducingNumber = reducingNumber - valueToSum
    }
    
    if (accumulatingRomanNumerals.characters.count <= 0) {
        return "invalid";
    }
    
    return accumulatingRomanNumerals
}




print("I\u{305}V\u{305}X\u{305}L\u{305}C\u{305}D\u{305}M\u{305}")
print("V\u{305}")


romanToNum("XLCCII")
romanToNum("VIV")
romanToNum("M̅C̅M̅X̅C̅I̅X̅CMXCIX")

assert(romanToNum("CCXL") == 240)
assert(romanToNum("CCXLI") == 241)
assert(romanToNum("CCXLII") == 242)
assert(romanToNum("MMCCCXXVI") == 2326)
assert(romanToNum("MMCCCXXVII") == 2327)
assert(romanToNum("MMCCCXXVIII") == 2328)
assert(romanToNum("MMMCDLXXXVI") == 3486)
assert(romanToNum("MMMCDLXXXVII") == 3487)
assert(romanToNum("MMMDCCXXXVII") == 3737)
assert(romanToNum("MMMDCCXXXVIII") == 3738)
assert(romanToNum("MMMDCCXXXIX") == 3739)
assert(romanToNum("CMXCIX") == 999)
assert(romanToNum("CMLXXXVIII") == 988)
assert(romanToNum("XLV") == 45)
assert(romanToNum("CDIV") == 404)
assert(romanToNum("XCIX") == 99)
assert(romanToNum("D̅C̅C̅L̅X̅X̅V̅I̅I̅DCCLXXVII") == 777777)
assert(romanToNum("D̅C̅C̅C̅L̅X̅X̅X̅V̅I̅I̅I̅DCCCLXXXVIII") == 888888)
assert(romanToNum("C̅M̅X̅C̅I̅X̅CMXCIX") == 999999)
assert(romanToNum("M̅C̅M̅X̅C̅I̅X̅CMXCIX") == 1999999) // This is the highest number we can do
assert(romanToNum("IC") == -1) // Invalid NOT 99
assert(romanToNum("") == -1) // Invalid
assert(romanToNum("VIV") == -1) // Invalid NOT 11
assert(romanToNum("LXXXXVI") == -1) // Invalid NOT 96

assert(numToRoman(999) == "CMXCIX")
assert(numToRoman(988) == "CMLXXXVIII")
assert(numToRoman(45) == "XLV")
assert(numToRoman(404) == "CDIV")
assert(numToRoman(99) == "XCIX")
assert(numToRoman(96) == "XCVI")
assert(numToRoman(4777) == "I̅V̅DCCLXXVII")
assert(numToRoman(4778) == "I̅V̅DCCLXXVIII")
assert(numToRoman(4779) == "I̅V̅DCCLXXIX")
assert(numToRoman(4780) == "I̅V̅DCCLXXX")
assert(numToRoman(4998) == "I̅V̅CMXCVIII")
assert(numToRoman(4999) == "I̅V̅CMXCIX")
assert(numToRoman(5000) == "V̅")
assert(numToRoman(1000000) == "M̅")
assert(numToRoman(777777) == "D̅C̅C̅L̅X̅X̅V̅I̅I̅DCCLXXVII")
assert(numToRoman(888888) == "D̅C̅C̅C̅L̅X̅X̅X̅V̅I̅I̅I̅DCCCLXXXVIII")
assert(numToRoman(999999) == "C̅M̅X̅C̅I̅X̅CMXCIX")
assert(numToRoman(1999999) == "M̅C̅M̅X̅C̅I̅X̅CMXCIX") // This is the highest number we can do
assert(numToRoman(2000000) == "invalid")

assert(numToRoman(3931) == "MMMCMXXXI")
assert(numToRoman(3932) == "MMMCMXXXII")

assert(numToRoman(-1) == "invalid")
assert(numToRoman(-99) == "invalid")
assert(numToRoman(0) == "invalid")
assert(numToRoman(10000000) == "invalid")


numToRoman(5088)


let III = "III"
let three = 3
assert(romanToNum(III) == three, "the number III is 3")
assert(numToRoman(three) == III, "the number 3 is III")
// associative?? commutative??
assert(romanToNum(numToRoman(three)) == three, "3 -> III -> 3")
assert(numToRoman(romanToNum(III)) == III, "III -> 3 -> III")
//
let IV = "IV"
assert(romanToNum(IV) == 4, "IV is four")



