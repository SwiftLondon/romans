//
//  RomanNumbersTests.swift
//  RomanNumbersTests
//
//  Created by Christian Scheid on 3/31/16.
//  Copyright © 2016 Christian Scheid. All rights reserved.
//

import XCTest
@testable import RomanNumbers

class RomanNumbersTests: XCTestCase {

    var converter : RomanNumbersConverter!
    
    override func setUp() {
        super.setUp()
        converter = RomanNumbersConverter()
    }
    
    func testConvertRomanLiteral_I() {
        let result = try! converter.romanToNum("I")
        XCTAssertEqual(result, 1)
    }
    
    func testConvertRomanLiteral_II() {
        let result = try! converter.romanToNum("II")
        XCTAssertEqual(result, 2)
    }
    
    func testConvertRomanLiteral_III() {
        let result = try! converter.romanToNum("III")
        XCTAssertEqual(result, 3)
    }
    
    func testConvertRomanLiteral_IV() {
        let result = try! converter.romanToNum("IV")
        XCTAssertEqual(result, 4)
    }
    
    func testConvertRomanLiteral_V() {
        let result = try! converter.romanToNum("V")
        XCTAssertEqual(result, 5)
    }
    
    func testConvertRomanLiteral_VI() {
        let result = try! converter.romanToNum("VI")
        XCTAssertEqual(result, 6)
    }
    
    func testConvertRomanLiteral_VII() {
        let result = try! converter.romanToNum("VII")
        XCTAssertEqual(result, 7)
    }
    
    func testConvertRomanLiteral_VIII() {
        let result = try! converter.romanToNum("VIII")
        XCTAssertEqual(result, 8)
    }
    
    func testConvertRomanLiteral_IX() {
        let result = try! converter.romanToNum("IX")
        XCTAssertEqual(result, 9)
    }
    
    func testConvertRomanLiteral_X() {
        let result = try! converter.romanToNum("X")
        XCTAssertEqual(result, 10)
    }
    
    func testConvertRomanLiteral_XI() {
        let result = try! converter.romanToNum("XI")
        XCTAssertEqual(result, 11)
    }
    
    func testConvertRomanLiteral_XII() {
        let result = try! converter.romanToNum("XII")
        XCTAssertEqual(result, 12)
    }
    
    func testConvertRomanLiteral_XVI() {
        let result = try! converter.romanToNum("XVI")
        XCTAssertEqual(result, 16)
    }
    
    func testConvertRomanLiteral_XVII() {
        let result = try! converter.romanToNum("XVII")
        XCTAssertEqual(result, 17)
    }
    
    func testConvertRomanLiteral_XIX() {
        let result = try! converter.romanToNum("XIX")
        XCTAssertEqual(result, 19)
    }
    
    func testConvertRomanLiteral_XXI() {
        let result = try! converter.romanToNum("XXI")
        XCTAssertEqual(result, 21)
    }
    
    func testConvertRomanLiteral_XXXIV() {
        let result = try! converter.romanToNum("XXXIV")
        XCTAssertEqual(result, 34)
    }
    
    func testConvertRomanLiteral_XXXIX() {
        let result = try! converter.romanToNum("XXXIX")
        XCTAssertEqual(result, 39)
    }
    
    func testConvertRomanLiteral_XLIX() {
        let result = try! converter.romanToNum("XLIX")
        XCTAssertEqual(result, 49)
    }
    
    func testConvertRomanLiteral_CLXIX() {
        let result = try! converter.romanToNum("CLXIX")
        XCTAssertEqual(result, 169)
    }
    
    func testConvertRomanLiteral_CXCIV() {
        let result = try! converter.romanToNum("CXCIV")
        XCTAssertEqual(result, 194)
    }
    
    func testConvertRomanLiteral_CDXCIX() {
        let result = try! converter.romanToNum("CDXCIX")
        XCTAssertEqual(result, 499)
    }
    
    // MARK: Conversion Errors
    
    func assertError(romanNum:String, conversionError:RomanLiteralConversionError) {
        do {
            try converter.romanToNum(romanNum)
            XCTFail("Expected error to be thrown")
        }
        catch let err as RomanLiteralConversionError {
            XCTAssertEqual(err, conversionError)
        }
        catch {
            XCTFail("Unexpected error")
        }
    }
    
    func testConvertRomanLiteral_UnknownLiteral_Y() {
        assertError("CDY", conversionError: RomanLiteralConversionError.InvalidLiteral)
    }
    
    func testConvertRomanLiteral_TooMany_X() {
        assertError("XXXXX", conversionError: RomanLiteralConversionError.InvalidLiteral)
    }
    
    func testConvertRomanLiteral_II_Before_XXX() {
        assertError("IIXXX", conversionError: RomanLiteralConversionError.InvalidLiteral)
    }
}
