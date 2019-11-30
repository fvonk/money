//
//  Solution.swift
//  PriceToWords
//
//  Created by Pavel Kozlov on 26.11.2019.
//  Copyright © 2019 Pavel. All rights reserved.
//

import Foundation


/// Main Solution Function
/// - Parameter value: input price in string
/// - Returns: A single, concatenated string.
func priceToWords(_ value: String) -> String {
    do {
        let price = try validateInput(value)
        return "\(toWords(price.dollars, unit: .dollar)) \(andWord.uppercased()) \(toWords(price.cents, unit: .cent))"
    } catch {
        return (error as? ValidationError)?.rawValue ?? error.localizedDescription
    }
}

/// check input
/// - Parameter value: input price in string
/// - Returns: Price type if input correct
private func validateInput(_ value: String) throws -> Price {
    guard (value.filter{ $0 == "." }).count <= 1 else { throw ValidationError.wrongFormat }
    let parts = value.split(separator: ".") //check if price has dot
    var dollars: Int = 0
    var cents: Int = 0
    
    switch parts.count {
    case 1: // only one part - dollars or cents
        if value.hasPrefix(".") {
            cents = try validate(cents: try convertToInt(String(parts[0])), value: String(parts[0]))
        } else {
            dollars = try convertToInt(String(parts[0]))
        }
    case 2: // two parts - dollars and cents
        dollars = try convertToInt(String(parts[0]))
        cents = try validate(cents: try convertToInt(String(parts[1])), value: String(parts[1]))
    default:
        throw ValidationError.wrongFormat
    }
    
    guard dollars >= 0 else { throw ValidationError.negative }
    guard dollars <= maximumValue else { throw ValidationError.tooLarge }
    return Price(dollars, cents)
}

/// Validate cents
/// - Parameters:
///   - cents: cents Int after cast Int from String
///   - value: cents from raw string
/// - Returns: corrected cents in Int
private func validate(cents: Int, value: String) throws -> Int {
    guard value.count <= maxDecimals else { throw ValidationError.moreThan2Decimals }
    return cents * (value.count == 1 ? 10: 1)//0.1 is 10 cents => increase 10 times
}

/// Converting String to Int if can
/// - Parameter value: input string
/// - Returns: Int and throws error if can't parse
private func convertToInt(_ value: String) throws -> Int {
    guard let dollarsValue = Int(value) else { throw ValidationError.wrongFormat }
    return dollarsValue
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
