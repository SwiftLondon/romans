//: Convert to and from Roman numerals
//: - [GitHub](https://github.com/HcomCoolCode/romans)
//: - [Stash](http://stash.hcom/users/mmatyjas/repos/romans/browse)

import Foundation

func romanToNum(romanNumber: String) -> Int {
    return romanNumber.characters.count
}

func numToRoman(number: Int) -> String {
    let romanArray = [Character](count: number, repeatedValue: "I")
    return String(romanArray)
}


let III = "III"
let three = 3
assert(romanToNum(III) == three, "the number III is 3")
assert(numToRoman(three) == III, "the number 3 is III")
// associative?? commutative??
assert(romanToNum(numToRoman(three)) == three, "3 -> III -> 3")
assert(numToRoman(romanToNum(III)) == III, "III -> 3 -> III")

let IV = "IV"
assert(romanToNum(IV) == 4, "IV is four")
