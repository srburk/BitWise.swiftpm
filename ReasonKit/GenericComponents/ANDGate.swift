//
//  ANDGate.swift
//
//
//  Created by Sam Burkhard on 2/1/24.
//

import Foundation
import SwiftUI

class ANDGate: BaseReasonComponent {
    
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
    
    func compute() {
        
        let value = inputConnections.allSatisfy({ $0.value })
        
        for outputConnection in self.outputConnections {
            outputConnection.value = value
        }
    }
    
    var shape: any Shape {
        return Capsule()
    }
    var position: CGPoint = .zero
}

extension ANDGate {
    var description: String {
        return """
        ID: \(id)
        Type: AND Gate
        Label: \(self.label)
        InputCount: \(self.inputCount)
        OutputCount: \(self.outputCount)
        Inputs: \(self.inputConnections.compactMap({ "\($0.head.label) | \($0.value)" }))
        Outputs: \(self.outputConnections.compactMap({ "\($0.tail.label) | \($0.value)" }))
        ProcessingGroup: \(self.processingGroup)
        """
    }
}
