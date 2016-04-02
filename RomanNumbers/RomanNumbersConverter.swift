//
//  RomanNumbersConverter.swift
//  RomanNumbers
//
//  Created by Christian Scheid on 3/31/16.
//  Copyright © 2016 Christian Scheid. All rights reserved.
//

import UIKit

enum RomanLiteralConversionError : ErrorType {
    case UnknownLiteral
}

struct Converter {
    
}

class RomanNumbersConverter: NSObject {
    
    private let mappingTable = [
        "I"     :    1,
        "IV"    :    4,
        "V"     :    5,
        "IX"    :    9,
        "X"     :   10,
        "XL"    :   40,
        "L"     :   50,
        "XC"    :   90,
        "C"     :  100,
        "CD"    :  400,
        "D"     :  500,
        "CM"    :  900,
        "M"     : 1000
    ]
    
    func convertRomanString(romanCharacters:[Character], symbolLength:Int = 2, result:Int = 0) throws -> Int {
        if romanCharacters.count == 0 {
            return result
        }
        else {
            let parsingLength = min(romanCharacters.count, symbolLength)
            let symbolToParse = String(romanCharacters.suffix(parsingLength))
            
            if let convertedNumber = mappingTable[symbolToParse] {
                let remainingCharacters = Array(romanCharacters.dropLast(parsingLength))
                return try convertRomanString(remainingCharacters, symbolLength: 2, result: result + convertedNumber)
            }
            // In case a two-character symbol could not be found
            // we shall try once more with one character only
            else if symbolLength == 2 {
                return try convertRomanString(romanCharacters, symbolLength: 1, result: result)
            }
            else {
                throw RomanLiteralConversionError.UnknownLiteral
            }
        }
    }
    
    func romanToNum(romanNumber: String) throws -> Int {
        let romanCharacters = Array(romanNumber.characters)
        return try convertRomanString(romanCharacters)
    }
    
    func numToRoman(number: Int) -> String {
        let romanArray = [Character](count: number, repeatedValue: "I")
        return String(romanArray)
    }
}
