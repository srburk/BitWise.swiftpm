//
//  NOTGate.swift
//
//
//  Created by Sam Burkhard on 2/20/24.
//

import Foundation
import SwiftUI

class NOTGate: BaseReasonComponent {
    
    var id: UUID
    var label: String
        
    var inputConnections: [ComponentConnector]
    var outputConnections: [ComponentConnector]
    var processingGroup: Int
        
    required init(label: String) {
        self.id = UUID()
        self.label = label
        
        self.inputConnections = [.input]
        self.outputConnections = [.output]
        
        self.processingGroup = 0
    }
    
    func compute() {
        
        if let connector = inputConnections.first {
            let value = !connector.value
            
            for outputConnection in self.outputConnections {
                outputConnection.setValue(value)
            }
        }
    }
    
    var type: ReasonComponentType = .other
    
    var shape: any Shape {
        NOTShape()
    }
    var position: CGPoint = .zero
}

extension NOTGate {
    var description: String { "Not Gate" }
}
