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

func * (left: String, right: Int) -> String {
    if (right < 0) {
        return ""
    } else {
        return String.fromRepeatsOf(count: right, repeatedValue: left)
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

/*
 "LXIV" -> [.L, .X, .I, .V] -> [(.L, .X), (.X, .I), (.I, .V), (.V, .V)] -> [(.L, +), (.X, +), (.I, -), (.V, +)] -> 0 + 50 + 10 - 1 + 5 -> 64
 1. parse
 2. tuples (tokens[i], tokens[i+1})
 3. tuples (token, op = tokens[i] < tokens[i+1] ? (-) : (+) )
 4. reduce with token.rawValue and op
*/
func romanToNum(romanNumber: String) -> Int {
    struct SymbolPair {
        let current: RomanNumeralSymbol
        let next: RomanNumeralSymbol
    }
    
    struct Command {
        let symbol: RomanNumeralSymbol
        let op: (Int, Int) -> Int
    }

    func parseTokens(romanNumber: String) -> [RomanNumeralSymbol] {
        return romanNumber.characters.map({(character: Character) in RomanNumeralSymbol.parse(character)!})
    }

    func convertToSymbolPairs(tokens: [RomanNumeralSymbol]) -> [SymbolPair] {
        return tokens.reverse()
            .reduce([SymbolPair](), combine: {(accumulator, symbol) in accumulator + [SymbolPair(current: symbol, next: accumulator.last?.current ?? symbol)]})
    }
    
    func convertToCommands(pairs: [SymbolPair]) -> [Command] {
        return pairs.map({(symbolPair: SymbolPair) -> Command in
            Command(symbol: symbolPair.current, op: symbolPair.current.rawValue < symbolPair.next.rawValue ? (-) : (+))})
    }
    
    func evaluateCommands(commands: [Command]) -> Int {
        return commands.reduce(0, combine: {(accumulator: Int, command: Command) -> Int in command.op(accumulator, command.symbol.rawValue)})
    }
    

    return evaluateCommands(convertToCommands(convertToSymbolPairs(parseTokens(romanNumber))))
}

func numToRoman(number: Int) -> String {
    // todo! move rule table
    let lowSymbolPrefix = [0:0, 1:1, 2:2, 3:3, 4:1, 5:0, 6:0, 7:0, 8:0, 9:0]
    let pivotSymbol = [0:0, 1:0, 2:0, 3:0, 4:1, 5:1, 6:1, 7:1, 8:1, 9:0]
    let lowSymbolPostfix = [0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:1, 7:2, 8:3, 9:1]
    let highSymbol = [0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:1]

    func thousandsOf(number: Int) -> String {
        return String.fromRepeatsOf(count: number / 1000, repeatedValue: RomanNumeralSymbol.M.string)
    }
    
    // pivot: middle symbol in the range of hundreds / tens / ones, i.e: D, L, V
    func lowerRanks(number: Int, pivot: RomanNumeralSymbol) -> String {
        let modulo = (number / pivot.prev!.rawValue) % 10
        return pivot.prev!.string * lowSymbolPrefix[modulo]!
            + pivot.string * pivotSymbol[modulo]!
            + pivot.prev!.string * lowSymbolPostfix[modulo]!
            + pivot.next!.string * highSymbol[modulo]!
    }

    return thousandsOf(number) + RomanNumeralSymbol.pivots.map({lowerRanks(number, pivot: $0)}).reduce("", combine: {$1 + $0})
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
assert(romanToNum("X") == 10, "X is 10")
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
assert(numToRoman(10) == "X", "X is 10")
assert(numToRoman(17) == "XVII", "XVII is 17")
assert(numToRoman(39) == "XXXIX", "XXXIX is 39")
assert(numToRoman(89) == "LXXXIX", "LXXXIX is 89")
assert(numToRoman(1981) == "MCMLXXXI", "MCMLXXXI is 1981")
assert(numToRoman(2016) == "MMXVI", "MMXVI is 2016")
