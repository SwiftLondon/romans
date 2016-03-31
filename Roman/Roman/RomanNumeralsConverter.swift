//
//  ArabicToRomanNumeralsConverter.swift
//  Roman
//
//  Created by Michael Voong on 25/03/2016.
//  Copyright © 2016 Hotels.com. All rights reserved.
//

import Foundation

typealias NumeralPair = (value: UInt, numeral: String)

let latinToRomainPairs: [NumeralPair] =
    [(1000, "M"),
     (1000, "M"),
     (1000, "M"),
     (1000, "M"),
     (900, "CM"),
     (500, "D"),
     (500, "D"),
     (500, "D"),
     (400, "CD"),
     (100, "C"),
     (100, "C"),
     (100, "C"),
     (90, "XC"),
     (50, "L"),
     (50, "L"),
     (50, "L"),
     (40, "XL"),
     (10, "X"),
     (10, "X"),
     (10, "X"),
     (9, "IX"),
     (5, "V"),
     (5, "V"),
     (5, "V"),
     (4, "IV"),
     (1, "I"),
     (1, "I"),
     (1, "I")]

enum Error: ErrorType {
    case InvalidInput(reason: String)
}

func arabicToRomanNumerals(number: UInt) throws -> String {
    guard number > 0 else {
        throw Error.InvalidInput(reason: "Number cannot be 0")
    }
    
    var remainingNumber = number
    var numerals = ""
    
    for pair in latinToRomainPairs {
        if pair.value <= remainingNumber  {
            remainingNumber -= pair.value
            numerals += pair.numeral
            if remainingNumber == 0 {
                break
            }
        }
    }
    
    if remainingNumber > 0 {
        throw Error.InvalidInput(reason: "Invalid number")
    }
    
    return numerals
}

func romanNumeralsToArabic(numerals: String) throws -> UInt {
    guard numerals.characters.count > 0 else {
        throw Error.InvalidInput(reason: "Must not pass empty string")
    }
    
    var value = UInt(0)
    let scanner = NSScanner(string: numerals)
    scanner.charactersToBeSkipped = nil
    
    for pair in latinToRomainPairs {
        if scanner.scanString(pair.numeral, intoString: nil) {
            value += pair.value
            if scanner.atEnd {
                break
            }
        }
    }
    
    if !scanner.atEnd {
        throw Error.InvalidInput(reason: "Invalid numerals")
    }
    
    let correctNumerals = try arabicToRomanNumerals(value)
    if correctNumerals.caseInsensitiveCompare(numerals) != .OrderedSame {
        throw Error.InvalidInput(reason: "Numerals for \(value) should be \(correctNumerals)")
    }
    
    return value
}
