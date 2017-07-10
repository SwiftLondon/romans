//: Convert to and from Roman numerals

import UIKit

func romanToNum(romanNumber: String) -> Int {
    return romanNumber.characters.count
}

func numToRoman(number: Int) -> String {
    let romanArray = [Character](repeating: "I", count: number)
    return String(romanArray)
}


let III = "III"
let three = 3
assert(romanToNum(romanNumber: III) == three, "the number III is 3")
assert(numToRoman(number: three) == III, "the number 3 is III")
// associative?? commutative??
assert(romanToNum(romanNumber: numToRoman(number: three)) == three, "3 -> III -> 3")
assert(numToRoman(number: romanToNum(romanNumber: III)) == III, "III -> 3 -> III")

let IV = "IV"
assert(romanToNum(romanNumber: IV) == 4, "IV should be four")
