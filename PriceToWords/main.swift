//
//  main.swift
//  PriceToWords
//
//  Created by Pavel on 26.11.2019.
//  Copyright © 2019 Pavel. All rights reserved.
//

import Foundation

// Start program
print("enter value (type \"q\" and press \"Enter\" for quit):")
while let arr = readLine() {
    if arr == "q" {
        exit(0)
    } else {
        print(priceToWords(arr))
    }
    print("Enter new value if you want:")
}

