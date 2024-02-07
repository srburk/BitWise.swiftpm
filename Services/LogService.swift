//
//  LogService.swift
//
//
//  Created by Sam Burkhard on 2/1/24.
//

import Foundation
import os

struct Log {
    
    static private let subsystem = "com.samburkhard.BitWise"
    
    static let general = Logger(subsystem: subsystem, category: "general")
    static let editor = Logger(subsystem: subsystem, category: "editor")
    static let reason = Logger(subsystem: subsystem, category: "reason")
    
}
