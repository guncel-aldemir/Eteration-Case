//
//  Logger.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 13.07.2025.
//

import Foundation
import os.log

extension Logger {
    static  var subsystem = Bundle.main.bundleIdentifier!
static let home = Logger(subsystem: subsystem, category: "home")
    static let network = Logger(subsystem: subsystem, category: "network")
    static let navigation = Logger(subsystem: subsystem, category: "navigation")
    static let storedCart = Logger(subsystem: subsystem, category: "storedCart")
}
