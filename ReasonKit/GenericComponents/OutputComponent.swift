//
//  File.swift
//  
//
//  Created by Sam Burkhard on 2/6/24.
//

import Foundation
import SwiftUI

class OutputComponent: BaseReasonComponent {
        
    var id: UUID
    var label: String
    
    var inputConnections: [ComponentConnector] = [.input]
    var outputConnections: [ComponentConnector] = []
    
    var output: Bool = false // this is the special output component interaction (shared with inputcomponent)
    
    var processingGroup: Int = 0
        
    required init(label: String) {
        self.id = UUID()
        self.label = label
    }
    
    public func compute() {
        self.output = inputConnections.contains(where: { $0.value })
    }
    
    var type: ReasonComponentType = .output
    
    var shape: any Shape {
        return Rectangle()
    }
    var position: CGPoint = .zero
    
}

extension OutputComponent {
    
    var description: String {
        return "Output"
//        ID: \(id)
//        Type: Output
//        Label: \(self.label)
//        Inputs: \(self.inputConnections.compactMap({ "\($0.head.label) | \($0.value)" }))
//        """
    }
}
