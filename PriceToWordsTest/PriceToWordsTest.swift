//
//  PriceToWordsTest.swift
//  PriceToWordsTest
//
//  Created by Pavel Kozlov on 26.11.2019.
//  Copyright © 2019 Pavel. All rights reserved.
//

import XCTest

class PriceToWordsTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //    MARK: - CORRECT INPUTS
    func testInteger() {
        let result = priceToWords("10")
        let expected = "ten \(MeasurementUnit.dollar.rawValue.uppercased())S \(andWord.uppercased()) zero \(MeasurementUnit.cent.rawValue.uppercased())S"
        print("  result: \(result)\nexpected: \(expected)")
        XCTAssert(result == expected)
    }

    func testPriceWithCents() {
        let result = priceToWords("123.12")
        let expected = "one hundred \(andWord) twenty three \(MeasurementUnit.dollar.rawValue.uppercased())S \(andWord.uppercased()) twelve \(MeasurementUnit.cent.rawValue.uppercased())S"
        print("  result: \(result)\nexpected: \(expected)")
        XCTAssert(result == expected)
    }
    
    func testZeroDollars() {
        let result = priceToWords("000000.01")
        let expected = "\(WordNumber.zero) \(MeasurementUnit.dollar.rawValue.uppercased())S \(andWord.uppercased()) one \(MeasurementUnit.cent.rawValue.uppercased())"
        print("  result: \(result)\nexpected: \(expected)")
        XCTAssert(result == expected)
    }
    
    func testMillionSyntax() {
        let result = priceToWords("1357256.32")
        let expected = "one million, three hundred \(andWord) fifty seven thousand, two hundred \(andWord) fifty six \(MeasurementUnit.dollar.rawValue.uppercased())S \(andWord.uppercased()) thirty two \(MeasurementUnit.cent.rawValue.uppercased())S"
        print("  result: \(result)\nexpected: \(expected)")
        XCTAssert(result == expected)
    }
    
    func testBillionSyntax() {
        let result = priceToWords("2000000000.00")
        let expected = "two billion \(MeasurementUnit.dollar.rawValue.uppercased())S \(andWord.uppercased()) zero \(MeasurementUnit.cent.rawValue.uppercased())S"
        print("  result: \(result)\nexpected: \(expected)")
        XCTAssert(result == expected)
    }
    
    func testOneCent() {
        let result = priceToWords("000010.01")
        let expected = "ten \(MeasurementUnit.dollar.rawValue.uppercased())S \(andWord.uppercased()) one \(MeasurementUnit.cent.rawValue.uppercased())"
        print("  result: \(result)\nexpected: \(expected)")
        XCTAssert(result == expected)
    }
    
    func testNotRound() {
        let result = priceToWords("1.99")
        let expected = "one \(MeasurementUnit.dollar.rawValue.uppercased()) \(andWord.uppercased()) ninety nine \(MeasurementUnit.cent.rawValue.uppercased())S"
        print("  result: \(result)\nexpected: \(expected)")
        XCTAssert(result == expected)
    }
    
    func testTenCents() {
        let result = priceToWords("1234.1")
        let expected = "one thousand, two hundred and thirty four \(MeasurementUnit.dollar.rawValue.uppercased())S \(andWord.uppercased()) ten \(MeasurementUnit.cent.rawValue.uppercased())S"
        print("  result: \(result)\nexpected: \(expected)")
        XCTAssert(result == expected)
    }
    
    func testPlusSign() {
        let result = priceToWords("+1234.6")
        let expected = "one thousand, two hundred and thirty four \(MeasurementUnit.dollar.rawValue.uppercased())S \(andWord.uppercased()) sixty \(MeasurementUnit.cent.rawValue.uppercased())S"
        print("  result: \(result)\nexpected: \(expected)")
        XCTAssert(result == expected)
    }
    
    func testDotDollarsSyntax() {
        let result = priceToWords(".99")
        let expected = "zero \(MeasurementUnit.dollar.rawValue.uppercased())S \(andWord.uppercased()) ninety nine \(MeasurementUnit.cent.rawValue.uppercased())S"
        print("  result: \(result)\nexpected: \(expected)")
        XCTAssert(result == expected)
    }
    
    func testDotCentsSyntax() {
        let result = priceToWords("123.")
        let expected = "one hundred and twenty three \(MeasurementUnit.dollar.rawValue.uppercased())S \(andWord.uppercased()) zero \(MeasurementUnit.cent.rawValue.uppercased())S"
        print("  result: \(result)\nexpected: \(expected)")
        XCTAssert(result == expected)
    }
    
    //    MARK: - MORE THAN 2 DECIMALS
    func testEdgeZeroCents() {
        let result = priceToWords("100.009999999")
        let expected = ValidationError.moreThan2Decimals.rawValue
        print("  result: \(result)\nexpected: \(expected)")
        XCTAssert(result == expected)
    }

    func testAllZero() {
        let result = priceToWords("000000.0012412467")
        let expected = ValidationError.moreThan2Decimals.rawValue
        print("  result: \(result)\nexpected: \(expected)")
        XCTAssert(result == expected)
    }
    
    func testOneDollar() {
        let result = priceToWords("000001.0012412467")
        let expected = ValidationError.moreThan2Decimals.rawValue
        print("  result: \(result)\nexpected: \(expected)")
        XCTAssert(result == expected)
    }
    
    func testDotCentsSyntaxMoreDecimals() {
        let result = priceToWords(".991")
        let expected = ValidationError.moreThan2Decimals.rawValue
        print("  result: \(result)\nexpected: \(expected)")
        XCTAssert(result == expected)
    }
    
    func testNotRoundToOneDollar() {
        let result = priceToWords("0.999999")
        let expected = ValidationError.moreThan2Decimals.rawValue
        print("  result: \(result)\nexpected: \(expected)")
        XCTAssert(result == expected)
    }
    
    //    MARK: - MORE THAN 2 DECIMALS
    func testBillionOver() {
        let result = priceToWords("2200000000.00")
        let expected = ValidationError.tooLarge.rawValue
        print("  result: \(result)\nexpected: \(expected)")
        XCTAssert(result == expected)
    }
    
    func testNegative() {
        let result = priceToWords("-112341235.20")
        let expected = ValidationError.negative.rawValue
        print("  result: \(result)\nexpected: \(expected)")
        XCTAssert(result == expected)
    }
    
    //    MARK: - WRONG FORMATS
    func testSeparatorSyntax() {
        let result = priceToWords("1_000.00")
        let expected = ValidationError.wrongFormat.rawValue
        print("  result: \(result)\nexpected: \(expected)")
        XCTAssert(result == expected)
    }
    
    func testPlusSignes() {
        let result = priceToWords("++1234.59")
        let expected = ValidationError.wrongFormat.rawValue
        print("  result: \(result)\nexpected: \(expected)")
        XCTAssert(result == expected)
    }
}
