//
//  File.swift
//  
//
//  Created by Sam Burkhard on 2/20/24.
//

import Foundation

final class ComponentConnector {
    
    public enum ConnectorType: String {
        case input, output
    }
    
    static var input: ComponentConnector { return ComponentConnector(type: .input) }
    static var output: ComponentConnector { return ComponentConnector(type: .output) }

    let id: UUID
    var connection: [ReasonConnection] // inputs can have only 1, outputs can have more
    let type: ConnectorType
    
    init(connection: [ReasonConnection] = [], type: ConnectorType) {
        self.id = UUID()
        self.connection = connection
        self.type = type
    }
    
    var value: Bool {
        if let wire = self.connection.first {
            return wire.value
        } else {
            return false
        }
    }
    
    func setValue(_ value: Bool) {
        // can be mulitple in future
        self.connection.forEach { connection in
            connection.value = value
        }
    }
    
}
