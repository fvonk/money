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

    func testCommon() {
        let result = priceToWords(123.12)
        let expected = "one hundred \(andWord) twenty three \(MeasurementUnit.dollar.rawValue.uppercased())S \(andWord.uppercased()) twelve \(MeasurementUnit.cent.rawValue.uppercased())S"
        print("  result: \(result)\nexpected: \(expected)")
        XCTAssert(result == expected)
    }
    
    func testEdgeZeroCents() {
        let result = priceToWords(100.000999999)
        let expected = "one hundred \(MeasurementUnit.dollar.rawValue.uppercased())S \(andWord.uppercased()) zero \(MeasurementUnit.cent.rawValue.uppercased())S"
        print("  result: \(result)\nexpected: \(expected)")
        XCTAssert(result == expected)
    }

    func testEdgeDollarCents() {
        let result = priceToWords(000000.01)
        let expected = "\(WordNumber.zero) \(MeasurementUnit.dollar.rawValue.uppercased())S \(andWord.uppercased()) one \(MeasurementUnit.cent.rawValue.uppercased())"
        print("  result: \(result)\nexpected: \(expected)")
        XCTAssert(result == expected)
    }
    
    func testMillion() {
        let result = priceToWords(1357256.32)
        let expected = "one million, three hundred \(andWord) fifty seven thousand, two hundred \(andWord) fifty six \(MeasurementUnit.dollar.rawValue.uppercased())S \(andWord.uppercased()) thirty two \(MeasurementUnit.cent.rawValue.uppercased())S"
        print("  result: \(result)\nexpected: \(expected)")
        XCTAssert(result == expected)
    }
    
    func testBillion() {
        let result = priceToWords(2000000000.00)
        let expected = "two billion \(MeasurementUnit.dollar.rawValue.uppercased())S \(andWord.uppercased()) zero \(MeasurementUnit.cent.rawValue.uppercased())S"
        print("  result: \(result)\nexpected: \(expected)")
        XCTAssert(result == expected)
    }
    
    func testBillionOver() {
        let result = priceToWords(2200000000.00)
        let expected = "two billion \(MeasurementUnit.dollar.rawValue.uppercased())S \(andWord.uppercased()) zero \(MeasurementUnit.cent.rawValue.uppercased())S"
        print("  result: \(result)\nexpected: \(expected)")
        XCTAssert(result != expected)
    }
    
    func testNegative() {
        let result = priceToWords(-112341235.20)
        let expected = "two billion \(MeasurementUnit.dollar.rawValue.uppercased())S \(andWord.uppercased()) zero \(MeasurementUnit.cent.rawValue.uppercased())S"
        print("  result: \(result)\nexpected: \(expected)")
        XCTAssert(result != expected)
    }
    
    func testAllZero() {
        let result = priceToWords(000000.0012412467)
        let expected = "zero \(MeasurementUnit.dollar.rawValue.uppercased())S \(andWord.uppercased()) zero \(MeasurementUnit.cent.rawValue.uppercased())S"
        print("  result: \(result)\nexpected: \(expected)")
        XCTAssert(result == expected)
    }
    
    func testOneDollar() {
        let result = priceToWords(000001.0012412467)
        let expected = "one \(MeasurementUnit.dollar.rawValue.uppercased()) \(andWord.uppercased()) zero \(MeasurementUnit.cent.rawValue.uppercased())S"
        print("  result: \(result)\nexpected: \(expected)")
        XCTAssert(result == expected)
    }
    
    func testOneCent() {
        let result = priceToWords(000010.01)
        let expected = "ten \(MeasurementUnit.dollar.rawValue.uppercased())S \(andWord.uppercased()) one \(MeasurementUnit.cent.rawValue.uppercased())"
        print("  result: \(result)\nexpected: \(expected)")
        XCTAssert(result == expected)
    }
    
    func testRound() {
        let result = priceToWords(1.99)
        let expected = "one \(MeasurementUnit.dollar.rawValue.uppercased()) \(andWord.uppercased()) ninety nine \(MeasurementUnit.cent.rawValue.uppercased())S"
        print("  result: \(result)\nexpected: \(expected)")
        XCTAssert(result == expected)
    }
    
    func testRoundToOneDollar() {
        let result = priceToWords(0.999999)
        let expected = "zero \(MeasurementUnit.dollar.rawValue.uppercased())S \(andWord.uppercased()) ninety nine \(MeasurementUnit.cent.rawValue.uppercased())S"
        print("  result: \(result)\nexpected: \(expected)")
        XCTAssert(result == expected)
    }
}
