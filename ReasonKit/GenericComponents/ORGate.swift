//
//  ORGate.swift
//  
//
//  Created by Sam Burkhard on 2/1/24.
//

import Foundation
import SwiftUI

class ORGate: BaseReasonComponent {
    
    var id: UUID
        
    var inputConnections: [ComponentConnector] = [.input, .input]
    var outputConnections: [ComponentConnector] = [.init(type: .output)]
    var processingGroup: Int
        
    required init(position: CGPoint = .zero) {
        self.id = UUID()
        self.position = position
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
            outputConnection.setValue(value)
        }
    }
    
    var type: ReasonComponentType = .other
    
    var shape: any Shape {
        return ORShape()
    }
    var position: CGPoint = .zero
}

// testing
extension ORGate {
    
    func moveTo(_ point: CGPoint) {
        self.position = point
    }
    
    var description: String {
        return "OR gate"
//        ID: \(id)
//        Type: OR Gate
//        Label: \(self.label)
//        InputCount: \(self.inputCount)
//        OutputCount: \(self.outputCount)
//        Inputs: \(self.inputConnections.compactMap({ "\($0.head.label) | \($0.value)" }))
//        Outputs: \(self.outputConnections.compactMap({ "\($0.tail.label) | \($0.value)" }))
//        ProcessingGroup: \(self.processingGroup)
//        """
    }
}
