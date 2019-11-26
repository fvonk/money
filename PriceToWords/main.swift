//
//  main.swift
//  PriceToWords
//
//  Created by Pavel on 26.11.2019.
//  Copyright © 2019 Pavel. All rights reserved.
//

import Foundation

print("enter value (type \"q\" and press \"Enter\" for quit):")
while let arr = readLine() {
    if arr == "q" {
        exit(0)
    } else if let value = Double(arr) {
        print(priceToWords(value))
    } else {
        print("wrong input")
    }
    print("Enter new value if you want:")
}

