/*: 
 # Romans is a programming excercise in a Swift Playground
 
 The problem is converting between [roman numerals](https://en.wikipedia.org/wiki/Roman_numerals) & western arabic numbers.
 
 Your challenge is to implement two functions
 1. romanToNum which takes Roman numbers as Strings and returns their numeric value
 2. numToRoman which takes a regular number and returns a roman one as a String

 We have provided a few tests which pass by chance and one that doesnt
 
 - Note:
 Written in the year MMXVI,
 revised in the year MMXVII
 */
import Foundation

// implement me!
func romanToNum(romanNumber: String) -> Int {
    return romanNumber.characters.count
}

// implement me too!
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
