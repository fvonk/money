//
//  Solution.swift
//  PriceToWords
//
//  Created by Pavel Kozlov on 26.11.2019.
//  Copyright © 2019 Pavel. All rights reserved.
//

import Foundation


/// Main Solution Function
/// - Parameter value: Double value to convert into English words
/// - Returns: A single, concatenated string.
func priceToWords(_ value: Double) -> String {
    guard value >= 0 else { return "amount can not be negative" }
    guard value < maximumValue else { return "amount exceeds 2 billions" }
    
    let price = roundedDouble(value)
    let cents = centsInInt(price)
    let dollars = dollarsInInt(price)

    return "\(toWords(dollars, unit: .dollar)) \(andWord.uppercased()) \(toWords(cents, unit: .cent))"
}

/// Round Double to 2 decimal signs
/// - Parameter value: input amount
private func roundedDouble(_ value: Double) -> Double {
    round(value * 100) / 100
}

/// Round decimal
/// - Parameter value: input value
private func centsInInt(_ value: Double) -> Int {
    Int(round(value * 100)) % 100
}

/// getting Int value of double
/// - Parameter value: input amount
private func dollarsInInt(_ value: Double) -> Int {
    Int(value)
}

/// Creating words about the value
/// - Parameters:
///   - value: input amount
///   - unit: measurement to apply correct word
private func toWords(_ value: Int, unit: MeasurementUnit) -> String {
    var values = [String]()
    var val = value
    for numberPart in NumberPart.allCases {
        if let wordsNumberPart = threeDigitsToWords(val % thousandStep) {
            values.append(wordsNumberPart + (numberPart == .hundred ? "" : spaceSign + numberPart.rawValue))
        }
        val /= thousandStep
    }
    return (values.isEmpty ? "\(WordNumber.zero)" : values.reversed().joined(separator: ", ")) + spaceSign + unit.valueString(value)
}

/// getting one three digit and creating words accorgingly
/// - Parameter value: input value (< 1000)
private func threeDigitsToWords(_ value: Int) -> String? {
    guard value > 0 else { return nil }
    return [oneDigitToWord(value / 100), getTwoIntsWords(value % 100)]
        .compactMap{ $0 }
        .joined(separator: spaceSign + andWord + spaceSign)
}

/// Third sign from the right - hundren
/// - Parameter digit: input digit (< 10)
private func oneDigitToWord(_ digit: Int) -> String? {
    guard digit > 0 else { return nil }
    return "\(WordNumber(rawValue: digit)!) \(NumberPart.hundred.rawValue)"
}

/// First and second sign from the right
/// - Parameter twoDigits: input digits (< 100)
private func getTwoIntsWords(_ twoDigits: Int) -> String? {
    guard twoDigits > 0 else { return nil }
    if let second = WordNumber(rawValue: twoDigits) {
        return "\(second)"
    } else {
        let secondDigit = WordNumber(rawValue: twoDigits / 10 * 10)!
        let thirdDigit = WordNumber(rawValue: twoDigits % 10)!
        return "\(secondDigit) \(thirdDigit)"
    }
}
