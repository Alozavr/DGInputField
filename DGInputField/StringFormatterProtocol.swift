//
//  StringFormatterProtocol.swift
//  DGInputFieldDemo
//
//  Created by Dmitry Grebenschikov on 31/01/2018.
//  Copyright © 2018 dd-team. All rights reserved.
//

import Foundation

public protocol StringFormatterProtocol {
    func format(_ string: String) -> String
    func removeFormat(_ string: String) -> String
}
