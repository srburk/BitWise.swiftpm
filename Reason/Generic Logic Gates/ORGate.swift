//
//  File.swift
//  
//
//  Created by Sam Burkhard on 2/1/24.
//

import Foundation

class ORGate: BaseReasonComponent {
    
    var id: UUID
    
    var label: String
    
    var inputConnections: [ReasonConnection]
    var outputConnections: [ReasonConnection]
    var processingGroup: Int
    
    required init(label: String) {
        self.id = UUID()
        self.label = label
        self.inputConnections = []
        self.outputConnections = []
        self.processingGroup = 0
    }
    
    func compute() -> Bool {
        return true
    }
}

extension ORGate {
    var description: String {
        return """

        =======================
        ID: \(id)
        Label: \(self.label)
        Inputs: \(self.inputConnections.compactMap({ $0.head.label }))
        Outputs: \(self.outputConnections.compactMap({ $0.tail.label }))
        ProcessingGroup: \(self.processingGroup)
        =======================
        """
    }
}
