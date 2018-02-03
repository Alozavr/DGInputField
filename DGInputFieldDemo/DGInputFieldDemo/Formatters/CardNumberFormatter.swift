//
//  CardNumberFormatter.swift
//  DGInputFieldDemo
//
//  Created by Dmitry Grebenschikov on 31/01/2018.
//  Copyright © 2018 dd-team. All rights reserved.
//

import Foundation

class CardNumberFormatter: StringFormatterProtocol {
    
    let groupSize = 4
    
    func format(_ string: String) -> String {
        let unformattedInput = removeFormat(string)
        var formatted = ""
        
        for (index, element) in unformattedInput.enumerated() {
            if (index % groupSize) == 0  && index != 0 {
                formatted.append(" ")
            }
            formatted.append(element)
        }
        
        return formatted
    }
    
    func removeFormat(_ string: String) -> String {
        return string.replacingOccurrences(of: " ", with: "")
    }
}
