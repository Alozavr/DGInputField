//
//  StringValidatorProtocol.swift
//  DGInputFieldDemo
//
//  Created by Dmitry Grebenschikov on 31/01/2018.
//  Copyright © 2018 dd-team. All rights reserved.
//

import Foundation

public protocol InputStringValidatorProtocol {
    func isValid(string: String) -> Bool
}
