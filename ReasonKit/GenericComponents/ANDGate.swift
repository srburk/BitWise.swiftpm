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
        
    var inputConnections: [ComponentConnector]
    var outputConnections: [ComponentConnector]
    var processingGroup: Int
        
    required init(position: CGPoint = .zero) {
        self.id = UUID()
        
        self.inputConnections = [.input, .input]
        self.outputConnections = [.output]
        
        self.position = position
        
        self.processingGroup = 0
    }
    
    func compute() {
        
        let value = inputConnections.allSatisfy { $0.value }
        
        for outputConnection in self.outputConnections {
            outputConnection.setValue(value)
        }
    }
    
    var type: ReasonComponentType = .other
    
    var shape: any Shape {
        ANDShape()
    }
    var position: CGPoint = .zero
}

extension ANDGate {
    var description: String {
        return "And Gate"
//        ID: \(id)
//        Type: AND Gate
//        Label: \(self.label)
//        InputCount: \(self.inputCount)
//        OutputCount: \(self.outputCount)
//        Inputs: \(self.inputConnections.compactMap({ "\($0.head.label) | \($0.value)" }))
//        Outputs: \(self.outputConnections.compactMap({ "\($0.tail.label) | \($0.value)" }))
//        ProcessingGroup: \(self.processingGroup)
//        """
    }
}
