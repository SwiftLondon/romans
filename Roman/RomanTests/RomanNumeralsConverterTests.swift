//
//  RomanNumeralsConverterTests.swift
//  Roman
//
//  Created by Michael Voong on 25/03/2016.
//  Copyright © 2016 Hotels.com. All rights reserved.
//

import XCTest

class RomanNumeralsConverterTests: XCTestCase {
    // Arabic to numerals
    func testArabicToRomanNumerals_simpleCases() {
        XCTAssertEqual(try arabicToRomanNumerals(30), "XXX")
        XCTAssertEqual(try arabicToRomanNumerals(4000), "MMMM")
        XCTAssertEqual(try arabicToRomanNumerals(4010), "MMMMX")
    }
    
    func testArabicToRomanNumerals_subtraction() {
        XCTAssertEqual(try arabicToRomanNumerals(4), "IV")
        XCTAssertEqual(try arabicToRomanNumerals(9), "IX")
        XCTAssertEqual(try arabicToRomanNumerals(556), "DLVI")
        XCTAssertEqual(try arabicToRomanNumerals(698), "DCXCVIII")
        XCTAssertEqual(try arabicToRomanNumerals(4999), "MMMMCMXCIX")
    }
    
    func testArabicToRomanNumerals_error() {
        XCTAssertThrowsError(try arabicToRomanNumerals(41004))
        XCTAssertThrowsError(try arabicToRomanNumerals(0))
    }
    
    func testArabicToRomanNumerals_performance() {
        measureBlock {
            do {
                for _ in 0..<100 {
                    XCTAssertEqual(try! arabicToRomanNumerals(30), "XXX")
                    XCTAssertEqual(try! arabicToRomanNumerals(4000), "MMMM")
                    XCTAssertEqual(try! arabicToRomanNumerals(4010), "MMMMX")
                    XCTAssertEqual(try! arabicToRomanNumerals(4), "IV")
                    XCTAssertEqual(try! arabicToRomanNumerals(9), "IX")
                    XCTAssertEqual(try! arabicToRomanNumerals(556), "DLVI")
                    XCTAssertEqual(try! arabicToRomanNumerals(698), "DCXCVIII")
                    XCTAssertEqual(try! arabicToRomanNumerals(4999), "MMMMCMXCIX")
                }
            }
        }
    }
    
    // Numerals to Arabic
    func testRomanNumeralsToArabic_simpleCases() {
        XCTAssertTrue(try romanNumeralsToArabic("I") == 1)
        XCTAssertTrue(try romanNumeralsToArabic("II") == 2)
        XCTAssertTrue(try romanNumeralsToArabic("III") == 3)
        XCTAssertTrue(try romanNumeralsToArabic("IV") == 4)
        XCTAssertTrue(try romanNumeralsToArabic("V") == 5)
        XCTAssertTrue(try romanNumeralsToArabic("VI") == 6)
        XCTAssertTrue(try romanNumeralsToArabic("VII") == 7)
        XCTAssertTrue(try romanNumeralsToArabic("VIII") == 8)
        XCTAssertTrue(try romanNumeralsToArabic("IX") == 9)
        XCTAssertTrue(try romanNumeralsToArabic("X") == 10)
        XCTAssertTrue(try romanNumeralsToArabic("XI") == 11)
        XCTAssertTrue(try romanNumeralsToArabic("XII") == 12)
        XCTAssertTrue(try romanNumeralsToArabic("XLV") == 45) // 10,50,5
    }
    
    func testRomanNumeralsToArabic_moreComplicatedCases() {
        XCTAssertTrue(try romanNumeralsToArabic("DCCC") == 800)
        XCTAssertTrue(try romanNumeralsToArabic("CCXXVI") == 226)
        XCTAssertTrue(try romanNumeralsToArabic("MDCCXII") == 1712)
        XCTAssertTrue(try romanNumeralsToArabic("XCIX") == 99) // 10,100,1,10
        XCTAssertTrue(try romanNumeralsToArabic("CDIV") == 404)
        XCTAssertTrue(try romanNumeralsToArabic("CMLXXXVIII") == 988) // 100,1000,50,30,8
        XCTAssertTrue(try romanNumeralsToArabic("MCMXIV") == 1914)
        XCTAssertTrue(try romanNumeralsToArabic("MMXVI") == 2016)
        XCTAssertTrue(try romanNumeralsToArabic("MCMXCVI") == 1996)
        XCTAssertTrue(try romanNumeralsToArabic("MMDLXIX") == 2569)
        XCTAssertTrue(try romanNumeralsToArabic("MMMM") == 4000) // 4 M's is fine
        XCTAssertTrue(try romanNumeralsToArabic("MMMMC") == 4100)
        XCTAssertTrue(try romanNumeralsToArabic("MMMMCMXCIX") == 4999) // Largest representable
    }
    
    func testRomanNumberalsToArabic_error() {
        XCTAssertThrowsError(try romanNumeralsToArabic("HELLO"))
        XCTAssertThrowsError(try romanNumeralsToArabic(" ASD"))
        XCTAssertThrowsError(try romanNumeralsToArabic(" "))
        XCTAssertThrowsError(try romanNumeralsToArabic(","))
        XCTAssertThrowsError(try romanNumeralsToArabic(""))
    }
    
    func testRomanNumberalsToArabic_performance() {
        measureBlock {
            do {
                for _ in 0..<100 {
                    XCTAssertTrue(try! romanNumeralsToArabic("DCCC") == 800)
                    XCTAssertTrue(try! romanNumeralsToArabic("CCXXVI") == 226)
                    XCTAssertTrue(try! romanNumeralsToArabic("MDCCXII") == 1712)
                    XCTAssertTrue(try! romanNumeralsToArabic("XCIX") == 99) // 10,100,1,10
                    XCTAssertTrue(try! romanNumeralsToArabic("CDIV") == 404)
                    XCTAssertTrue(try! romanNumeralsToArabic("CMLXXXVIII") == 988) // 100,1000,50,30,8
                    XCTAssertTrue(try! romanNumeralsToArabic("MCMXIV") == 1914)
                    XCTAssertTrue(try! romanNumeralsToArabic("MMXVI") == 2016)
                    XCTAssertTrue(try! romanNumeralsToArabic("MCMXCVI") == 1996)
                    XCTAssertTrue(try! romanNumeralsToArabic("MMDLXIX") == 2569)
                    XCTAssertTrue(try! romanNumeralsToArabic("MMMM") == 4000) // 4 M's is fine
                    XCTAssertTrue(try! romanNumeralsToArabic("MMMMC") == 4100)
                    XCTAssertTrue(try! romanNumeralsToArabic("MMMMCMXCIX") == 4999) // Largest representable
                }
            }
        }
    }
    
    // Mixed
    
    func testTransitive() {
        for i: UInt in 1...4999 {
            XCTAssertEqual(try romanNumeralsToArabic(arabicToRomanNumerals(i)), i)
        }
    }
}
