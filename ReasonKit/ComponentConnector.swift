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
    var connection: ReasonConnection?
    let type: ConnectorType
    
    init(connection: ReasonConnection? = nil, type: ConnectorType) {
        self.id = UUID()
        self.connection = connection
        self.type = type
    }
    
    var value: Bool {
        if let wire = self.connection {
            return wire.value
        } else {
            return false
        }
    }
    
    func setValue(_ value: Bool) {
        // can be mulitple in future
        self.connection?.value = value
    }
    
}
