//
//  RomanNumbersConverter.swift
//  RomanNumbers
//
//  Created by Christian Scheid on 3/31/16.
//  Copyright © 2016 Christian Scheid. All rights reserved.
//
//  With help from: http://www.rapidtables.com/convert/number/roman-numerals-converter.htm
//

import UIKit

enum RomanLiteralConversionError : ErrorType {
    case InvalidLiteral
}

struct SymbolMatcher {
    
    let symbol : String
    let value : Int
    let maxCount : Int
    
    func match(other:String) throws -> Bool {
        if symbol == other {
            if maxCount > 0 {
                return true
            }
            else {
                throw RomanLiteralConversionError.InvalidLiteral
            }
        }
        else {
            return false
        }
    }
    
    func consume() -> SymbolMatcher {
        return SymbolMatcher(symbol: symbol, value: value, maxCount: maxCount - 1)
    }
    
    func isExhausted() -> Bool {
        return maxCount == 0
    }
}

struct SymbolParser {
    
    let matchers : [SymbolMatcher]
    let result : Int
    
    // Generates a new parser if a symbol was found
    func parse(symbol:String) throws -> SymbolParser? {
        
        for (index, matcher) in matchers.enumerate() {

            if try matcher.match(symbol) {
                
                let newMatcher = matcher.consume()
                var remainingMatchers = matchers.suffixFrom(index + 1)
                if !newMatcher.isExhausted() {
                    remainingMatchers = [newMatcher] + remainingMatchers
                }
                return SymbolParser(matchers: Array(remainingMatchers), result: result + matcher.value)
            }
        }
        return nil
    }
}

class RomanNumbersConverter: NSObject {
    
    func generateSymbolMatchers() -> [SymbolMatcher] {
        return [
            SymbolMatcher(symbol: "I", value: 1, maxCount: 3),
            SymbolMatcher(symbol: "IV", value: 4, maxCount: 1),
            SymbolMatcher(symbol: "V", value: 5, maxCount: 1),
            SymbolMatcher(symbol: "IX", value: 9, maxCount: 1),
            SymbolMatcher(symbol: "X", value: 10, maxCount: 3),
            SymbolMatcher(symbol: "XL", value: 40, maxCount: 1),
            SymbolMatcher(symbol: "L", value: 50, maxCount: 1),
            SymbolMatcher(symbol: "XC", value: 90, maxCount: 1),
            SymbolMatcher(symbol: "C", value: 100, maxCount: 3),
            SymbolMatcher(symbol: "CD", value: 400, maxCount: 1),
            SymbolMatcher(symbol: "D", value: 500, maxCount: 1),
            SymbolMatcher(symbol: "CM", value: 900, maxCount: 1),
            SymbolMatcher(symbol: "M", value: 1000, maxCount: 4)
        ]
    }
    
    func convertRomanString(parser:SymbolParser, characters:[Character], symbolLength:Int = 2) throws -> Int {
        
        if characters.count == 0 {
            return parser.result
        }
        else {
            let parsingLength = min(characters.count, symbolLength)
            let symbolToParse = String(characters.suffix(parsingLength))
            
            if let newParser = try parser.parse(symbolToParse) {
                
                let remainingCharacters = characters.dropLast(parsingLength)
                return try convertRomanString(newParser, characters: Array(remainingCharacters), symbolLength: 2)
            }
            else if symbolLength == 2 {
                return try convertRomanString(parser, characters: characters, symbolLength: 1)
            }
            else {
                throw RomanLiteralConversionError.InvalidLiteral
            }
        }
    }
    
    func romanToNum(romanNumber: String) throws -> Int {
        let romanCharacters = Array(romanNumber.characters)
        let matchers = generateSymbolMatchers()
        let parser = SymbolParser(matchers: matchers, result: 0)
        return try convertRomanString(parser, characters: romanCharacters)
    }
    
    func numToRoman(number: Int) -> String {
        let romanArray = [Character](count: number, repeatedValue: "I")
        return String(romanArray)
    }
}
