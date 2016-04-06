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

struct Symbol {
    
    let symbol : String
    let decimalValue : Int
    let maxCount : Int
    
    func match(other:String) throws -> Bool {
        return maxCount > 0 && symbol == other
    }
    
    func consume() -> Symbol {
        return Symbol(symbol: symbol, decimalValue: decimalValue, maxCount: maxCount - 1)
    }
}

let romanSymbols = [
        Symbol(symbol: "I", decimalValue: 1, maxCount: 3),
        Symbol(symbol: "IV", decimalValue: 4, maxCount: 1),
        Symbol(symbol: "V", decimalValue: 5, maxCount: 1),
        Symbol(symbol: "IX", decimalValue: 9, maxCount: 1),
        Symbol(symbol: "X", decimalValue: 10, maxCount: 3),
        Symbol(symbol: "XL", decimalValue: 40, maxCount: 1),
        Symbol(symbol: "L", decimalValue: 50, maxCount: 1),
        Symbol(symbol: "XC", decimalValue: 90, maxCount: 1),
        Symbol(symbol: "C", decimalValue: 100, maxCount: 3),
        Symbol(symbol: "CD", decimalValue: 400, maxCount: 1),
        Symbol(symbol: "D", decimalValue: 500, maxCount: 1),
        Symbol(symbol: "CM", decimalValue: 900, maxCount: 1),
        Symbol(symbol: "M", decimalValue: 1000, maxCount: 4)
]

struct SymbolParser {
    
    let symbols : [Symbol]
    let result : Int
    
    func parse(romanLiteral:String) throws -> SymbolParser? {
        
        for (index, symbol) in symbols.enumerate() {

            if try symbol.match(romanLiteral) {
                
                let changedSymbol = symbol.consume()
                let remainingSymbols = [changedSymbol] + symbols.suffixFrom(index + 1)
                return SymbolParser(symbols: remainingSymbols, result: result + symbol.decimalValue)
            }
        }
        return nil
    }
}

class RomanNumbersConverter: NSObject {
    
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
        let parser = SymbolParser(symbols: romanSymbols, result: 0)
        return try convertRomanString(parser, characters: Array(romanNumber.characters))
    }
    
    func numToRoman(number: Int) -> String {
        let romanArray = [Character](count: number, repeatedValue: "I")
        return String(romanArray)
    }
}
