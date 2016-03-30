//: Convert to and from Roman numerals

import UIKit

/*:
 I, V, X
 | 1   | 2   | 3   | 4   | 5   | 6   | 7   | 8   | 9   |
 | --- | --- | --- | --- | --- | --- | --- | --- | --- |
 | I   | II  | III | IV  | V   | VI  | VII | VIII| IX  |
 
 X, L, C
 | 10  | 20  | 30  | 40  | 50  | 60  | 70  | 80  | 90  |
 | --- | --- | --- | --- | --- | --- | --- | --- | --- |
 | X   | XX  | XXX | XL  | L   | LX  | LXX | LXXX| XC  |
 
 C, D, M
 | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900 |
 | --- | --- | --- | --- | --- | --- | --- | --- | --- |
 | C   | CC  | CCC | CD  | D   | DC  | DCC | DCCC| CM  |
 
 M
 | 1000| 2000| 3000|
 | --- | --- | --- |
 | M   | MM  | MMM |
 
 */

extension String {
    static func fromRepeatsOf(count count: Int, repeatedValue: String) -> String {
        return Array(count: count, repeatedValue: repeatedValue).joinWithSeparator("")
    }
}

enum RomanNumeralSymbol: Int {
    case I = 1
    case V = 5
    case X = 10
    case L = 50
    case C = 100
    case D = 500
    case M = 1000
    
    static let pivots = [V, L, D]
    private static let previousSymbol: Dictionary<RomanNumeralSymbol, RomanNumeralSymbol?> = [I: nil, V: I, X: V, L: X, C: L, D: C, M: D]
    private static let nextSymbol: Dictionary<RomanNumeralSymbol, RomanNumeralSymbol?> = [I: V, V: X, X: L, L: C, C: D, D: M, M: nil]
    private static let symbolTable  = [I: "I", V: "V", X: "X", L: "L", C: "C", D: "D", M: "M"]
    private static let parseTable   = ["I": I, "V": V, "X": X, "L": L, "C": C, "D": D, "M": M]
    
    var string: String {
        get {
            return RomanNumeralSymbol.symbolTable[self]!
        }
    }
    var prev: RomanNumeralSymbol? {
        get {
            return RomanNumeralSymbol.previousSymbol[self]!
        }
    }
    var next: RomanNumeralSymbol? {
        get {
            return RomanNumeralSymbol.nextSymbol[self]!
        }
    }
    static func parse(char: Character) -> RomanNumeralSymbol? {
        return RomanNumeralSymbol.parseTable[String(char)]
    }
}

// NB! No validation on roman numeral string
func romanToNum(romanNumber: String) -> Int {
    struct Token {
        var symbol: RomanNumeralSymbol
        var count: Int
    }

    func parseTokens(romanNumber: String) -> [Token] {
        var tokens = [Token]()
        romanNumber.characters.forEach({(char: Character) in
            if let nextSymbol = RomanNumeralSymbol.parse(char) {
                if tokens.count < 1 || tokens.last!.symbol != nextSymbol {
                    tokens.append(Token(symbol: nextSymbol, count: 1))
                } else {
                    let oldToken = tokens.popLast()!
                    tokens.append(Token(symbol: nextSymbol, count: oldToken.count + 1));
                }
            }
        })
        return tokens
    }
    
    func evaluateTokens(tokens: [Token]) -> Int {
        var accumulator = 0
        let tokenCount = tokens.count
        for i in 0..<tokenCount {
            let currentToken = tokens[i]
            let currentTokenValue = currentToken.symbol.rawValue * currentToken.count
            if i < tokenCount-1 && currentToken.symbol.rawValue < tokens[i+1].symbol.rawValue {
                accumulator -= currentTokenValue
            } else {
                accumulator += currentTokenValue
            }
        }
        return accumulator
    }

    return evaluateTokens(parseTokens(romanNumber))
}

func numToRoman(number: Int) -> String {
    func thousandsOf(number: Int) -> String {
        return String.fromRepeatsOf(count: number / 1000, repeatedValue: RomanNumeralSymbol.M.string)
    }
    
    // pivot: middle symbol in the range of hundreds / tens / ones, i.e: D, L, V
    func lowerRanksOf(number: Int, pivot: RomanNumeralSymbol) -> String {
        let modulo = (number / pivot.prev!.rawValue) % 10
        switch modulo {
        case 0: return ""
        case 1...3: return String.fromRepeatsOf(count: modulo, repeatedValue: pivot.prev!.string)
        case 4...8: return String.fromRepeatsOf(count: max(5 - modulo, 0), repeatedValue: pivot.prev!.string)
            + pivot.string
            + String.fromRepeatsOf(count: max(modulo - 5, 0), repeatedValue: pivot.prev!.string)
        case 9: return pivot.prev!.string + pivot.next!.string
        default: return "?"
        }
    }

    return thousandsOf(number) + RomanNumeralSymbol.pivots.map({lowerRanksOf(number, pivot: $0)}).reduce("", combine: {$1 + $0})
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

// roman -> arabic
assert(romanToNum("II") == 2, "II is 2")
assert(romanToNum("III") == 3, "III is 3")
assert(romanToNum("IV") == 4, "IV is 4")
assert(romanToNum("V") == 5, "V is 5")
assert(romanToNum("VI") == 6, "VI is 6")
assert(romanToNum("VIII") == 8, "VIII is 8")
assert(romanToNum("IX") == 9, "IX is 9")
assert(romanToNum("XVII") == 17, "XVII is 17")
assert(romanToNum("XXXIX") == 39, "XXXIX is 39")
assert(romanToNum("LXXXIX") == 89, "LXXXIX is 89")
assert(romanToNum("MCMLXXXI") == 1981, "MCMLXXXI is 1981")
assert(romanToNum("MMXVI") == 2016, "MMXVI is 2016")
// arabic -> roman
assert(numToRoman(2) == "II", "II is 2")
assert(numToRoman(3) == "III", "III is 3")
assert(numToRoman(4) == "IV", "IV is 4")
assert(numToRoman(5) == "V", "V is 5")
assert(numToRoman(6) == "VI", "VI is 6")
assert(numToRoman(8) == "VIII", "VIII is 8")
assert(numToRoman(9) == "IX", "IX is 9")
assert(numToRoman(17) == "XVII", "XVII is 17")
assert(numToRoman(39) == "XXXIX", "XXXIX is 39")
assert(numToRoman(89) == "LXXXIX", "LXXXIX is 89")
assert(numToRoman(1981) == "MCMLXXXI", "MCMLXXXI is 1981")
assert(numToRoman(2016) == "MMXVI", "MMXVI is 2016")

