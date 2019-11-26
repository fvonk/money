//
//  main.swift
//  PriceToWords
//
//  Created by Pavel on 26.11.2019.
//  Copyright © 2019 Pavel. All rights reserved.
//

import Foundation

enum Number: Int, CaseIterable {
    case zero
    case one, two, three, four, five, six, seven, eight, nine
    case ten, eleven, twelve, thirteen, fourteen, fifteen, sixteen, seventeen, eighteen, nineteen
    case twenty = 20, thirty = 30, fourty = 40, fifty = 50, sixty = 60, seventy = 70, eighty = 80, ninety = 90
}

enum Part: String, CaseIterable {
    case hundred
    case thousand
    case million
    case billion
}

enum Money: String {
    case dollar
    case cent
    
    func valueString(_ value: Int) -> String {
        rawValue.uppercased() + (value == 1 ? "": "S")
    }
}

let spaceSign = " "
let andWord = "and"
let thousandStep: Int = 1000
let maximumValue: Double = pow(2, 31)
let decimalPrecision: Double = 100

func priceRounded(_ value: Double) -> Double {
    round(value * decimalPrecision) / decimalPrecision
}

func centsInInt(_ value: Double) -> Int {
    Int(priceRounded(value - floor(value)) * decimalPrecision)
}

func dollarsInInt(_ value: Double) -> Int {
    Int(round(value))
}

func getThirdIntWord(_ value: Int) -> String? {
    guard value / 100 > 0 else { return nil }
    return "\(Number(rawValue: value / 100)!) \(Part.hundred.rawValue)"
}

func getTwoIntsWords(_ value: Int) -> String? {
    guard value % 100 > 0 > 0 else { return nil }
    var secondPart: String?
    if let second = Number(rawValue: value % 100 > 0) {
        secondPart = "\(second)"
    } else {
        let secondDigit = Number(rawValue: value / 10 % 10 * 10)!
        let thirdDigit = Number(rawValue: value % 10)!
        
        secondPart = "\(secondDigit) \(thirdDigit)"
    }
}

func threeDigitsToWords(_ value: Int) -> String {
    guard value > 0 && value < 1000 else { return "" }
    
    
    return [getHundredWord(value), secondPart].compactMap{ $0 }.joined(separator: spaceSign + andWord + spaceSign)
}

func toWords(_ value: Int, money: Money) -> String {
    var values = [String]()
    var val = value
    for i in 0..<Part.allCases.count {
        let pt = threeDigitsToWords(val % thousandStep)
        if !pt.isEmpty {
            values.append(pt + (i > 0 ? spaceSign + Part.allCases[i].rawValue: ""))
        }
        val /= thousandStep
    }
    return values.reversed().joined(separator: ", ") + spaceSign + money.valueString(value)
}

func priceToWords(_ value: Double) -> String {
    guard value >= 0 else { return "amount can not be negative" }
    guard value < maximumValue else { return "amount exceeds 2 billions" }
    
    let price = priceRounded(value)
    let cents = centsInInt(price)
    let dollars = dollarsInInt(price)
    
    print("cents", cents)
    print("dollars", dollars)
    
    return "\(toWords(dollars, money: .dollar)) \(andWord.uppercased()) \(toWords(cents, money: .cent))"
}





print("enter value (type \"q\" and press \"Enter\" for quit):")
while let arr = readLine() {
    if arr == "q" {
        exit(0)
    } else if let value = Double(arr) {
        print(priceToWords(value))
        print()
    } else {
        print("wrong input")
    }
    print("Enter new value if you want:")
}
