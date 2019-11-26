//
//  PriceEnums.swift
//  PriceToWords
//
//  Created by Pavel Kozlov on 26.11.2019.
//  Copyright © 2019 Pavel. All rights reserved.
//

import Foundation


/// Number from 
enum WordNumber: Int, CaseIterable {
    case zero
    case one, two, three, four, five, six, seven, eight, nine
    case ten, eleven, twelve, thirteen, fourteen, fifteen, sixteen, seventeen, eighteen, nineteen
    case twenty = 20, thirty = 30, fourty = 40, fifty = 50, sixty = 60, seventy = 70, eighty = 80, ninety = 90
}

enum NumberPart: String, CaseIterable {
    case hundred
    case thousand
    case million
    case billion
}

enum MeasurementUnit: String {
    case dollar
    case cent
    
    func valueString(_ value: Int) -> String {
        rawValue.uppercased() + (value == 1 ? "": "S")
    }
}
