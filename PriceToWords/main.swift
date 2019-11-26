//
//  main.swift
//  PriceToWords
//
//  Created by Pavel on 26.11.2019.
//  Copyright © 2019 Pavel. All rights reserved.
//

import Foundation

enum Number: String {
    case zero, one, two, three, four, five, six, seven, eight, nine
    case billion, million, thousend, hundred
}

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

func priceToWords(_ value: Double) -> String {
    let price = priceRounded(value)
    let cents = centsInInt(price)
    let dollars = dollarsInInt(price)
    
    print("cents", cents)
    print("dollars", dollars)
    
    var result = ""
    return result
}





print("enter value (type \"q\" and press \"Enter\" for quit):")
while let arr = readLine() {
    if arr == "q" {
        exit(0)
    } else if let value = Double(arr) {
        if value < 0 {
            print("amount can not be negative")
        } else {
            print(priceToWords(value))
        }
    } else {
        print("wrong input")
    }
    print("Enter new value if you want:")
}
