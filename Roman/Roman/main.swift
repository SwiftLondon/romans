//
//  main.swift
//  Roman
//
//  Created by Michael Voong on 24/03/2016.
//  Copyright © 2016 Hotels.com. All rights reserved.
//

import Foundation

while (true) {
    do {
        let input = getKeyboardInput()
        
        print(try romanNumeralsToArabic(input))
//        print(try arabicToRomanNumerals(UInt(input) ?? 0))
    } catch Error.InvalidInput(let message) {
        print("Invalid input: \(message)")
    }
}

