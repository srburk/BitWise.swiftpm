//
//  ORGate.swift
//  
//
//  Created by Sam Burkhard on 2/1/24.
//

import Foundation

class ORGate: BaseReasonComponent {
    
    var id: UUID
    
    var label: String
    
    var inputCount: Int = 2
    var outputCount: Int = 1
    
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
    
    deinit {
        // testing to make sure things are freed when they need to be
        Log.reason.warning("Deinitialized component: \(self.id)")
    }
    
    func compute() {
        
        let value = inputConnections.contains(where: { $0.value })

        // there could be more logic for this based on what kind of output should exist
        for outputConnection in self.outputConnections {
            outputConnection.value = value
        }
    }
}

extension ORGate {
    var description: String {
        return """
        ID: \(id)
        Type: OR Gate
        Label: \(self.label)
        InputCount: \(self.inputCount)
        OutputCount: \(self.outputCount)
        Inputs: \(self.inputConnections.compactMap({ "\($0.head.label) | \($0.value)" }))
        Outputs: \(self.outputConnections.compactMap({ "\($0.tail.label) | \($0.value)" }))
        ProcessingGroup: \(self.processingGroup)
        """
    }
}
