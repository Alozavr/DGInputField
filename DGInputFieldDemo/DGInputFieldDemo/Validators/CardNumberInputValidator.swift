//
//  CardNumberInputValidator.swift
//  DGInputFieldDemo
//
//  Created by Dmitry Grebenschikov on 31/01/2018.
//  Copyright © 2018 dd-team. All rights reserved.
//

import Foundation

class CardNumberInputValidator: InputStringValidatorProtocol {
    
    let allowedCharacters = CharacterSet.decimalDigits
    let maxLength = 16
    
    func isValid(string: String) -> Bool {
        let containsOnlyAllowedChars = string.rangeOfCharacter(from: allowedCharacters.inverted) == nil
        return containsOnlyAllowedChars && string.count <= maxLength
    }
}
