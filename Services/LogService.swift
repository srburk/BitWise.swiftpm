//
//  Logger.swift
//
//
//  Created by Sam Burkhard on 2/1/24.
//

import Foundation
import os

struct Log {
    
    static private let subsystem = "com.samburkhard.BitWise"
    
    static let defaultLog = Logger(subsystem: subsystem, category: "default")
    
    static let notificationLog = Logger(subsystem: subsystem, category: "notifications")
    static let audioPlayerLog = Logger(subsystem: subsystem, category: "audioplayer")
    static let audioRecorderLog = Logger(subsystem: subsystem, category: "audiorecorder")
    static let signalProcessLog = Logger(subsystem: subsystem, category: "signalprocess")
    static let liveExerciseFeedback = Logger(subsystem: subsystem, category: "liveexercisefeedback")
    
}
