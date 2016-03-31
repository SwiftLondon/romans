//
//  KeyboardUtils.swift
//  Roman
//
//  Created by Michael Voong on 25/03/2016.
//  Copyright © 2016 Hotels.com. All rights reserved.
//

import Foundation

func getKeyboardInput() -> String {
    let keyboard = NSFileHandle.fileHandleWithStandardInput()
    let inputData = keyboard.availableData
    let string = NSString(data: inputData, encoding:NSUTF8StringEncoding) as! String
    
    return string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
}