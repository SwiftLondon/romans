//: Convert to and from Roman numerals

import UIKit

enum RomanNumeralSymbol: Int {
    case I = 1
    case V = 5
    case X = 10
    case L = 50
    case C = 100
    case D = 500
    case M = 1000
    static func parse(char: Character) -> RomanNumeralSymbol? {
        switch char {
        case "I":
            return I
        case "V":
            return V
        case "X":
            return X
        case "L":
            return L
        case "C":
            return C
        case "D":
            return D
        case "M":
            return M
        default:
            return nil
        }
    }
}

struct Token {
    var symbol: RomanNumeralSymbol
    var count: Int
}

func parseRomanNumeral(romanNumber: String) -> [Token] {
    var tokens = [Token]()
    romanNumber.characters.forEach({(char: Character) in
        if let nextSymbol = RomanNumeralSymbol.parse(char) {
            if tokens.count < 1 || tokens.last!.symbol != nextSymbol {
                tokens.append(Token(symbol: nextSymbol, count: 1))
            } else {
                let oldToken = tokens.popLast()!
                // validate count?
                tokens.append(Token(symbol: nextSymbol, count: oldToken.count + 1));
            }
        } else {
            // todo! handle invalid token
        }
    })
    return tokens
}

func processRomanNumeralTokens(tokens: [Token]) -> Int {
    var acc = 0
    let tokenCount = tokens.count
    for i in 0..<tokenCount {
        let currentToken = tokens[i]
        let currentTokenValue = currentToken.symbol.rawValue * currentToken.count
        if i < tokenCount-1 && currentToken.symbol.rawValue < tokens[i+1].symbol.rawValue {
            acc -= currentTokenValue
        } else {
            acc += currentTokenValue
        }
    }
    return acc
}

processRomanNumeralTokens(parseRomanNumeral("II"))
processRomanNumeralTokens(parseRomanNumeral("III"))
processRomanNumeralTokens(parseRomanNumeral("IV"))
processRomanNumeralTokens(parseRomanNumeral("V"))
processRomanNumeralTokens(parseRomanNumeral("VI"))
processRomanNumeralTokens(parseRomanNumeral("VIII"))
processRomanNumeralTokens(parseRomanNumeral("MMXVI"))


func romanToNum(romanNumber: String) -> Int {
    return processRomanNumeralTokens(parseRomanNumeral(romanNumber))
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

assert(romanToNum("II") == 2, "II is 2")
assert(romanToNum("III") == 3, "III is 3")
assert(romanToNum("IV") == 4, "IV is 4")
assert(romanToNum("V") == 5, "V is 5")
assert(romanToNum("VI") == 6, "VI is 6")
assert(romanToNum("VIII") == 8, "VIII is 8")
assert(romanToNum("MMXVI") == 2016, "MMXVI is 2016")

