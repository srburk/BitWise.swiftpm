//
//  InputComponent.swift
//
//
//  Created by Sam Burkhard on 2/6/24.
//

import Foundation
import SwiftUI

class InputComponent: BaseReasonComponent {
        
    var id: UUID
    var label: String
    
    var inputCount: Int = 0
    var outputCount: Int = 1
    
    var inputConnections: [ReasonConnection] = []
    var outputConnections: [ReasonConnection] = []
    
    private(set) var output: Bool = true // this is the special inputcomponent interaction
    
    var processingGroup: Int = 0
    
    required init(label: String) {
        self.id = UUID()
        self.label = label
    }
    
    public func initialValue(_ value: Bool) -> BaseReasonComponent {
        self.output = value
        return self
    }
    
    public func toggle() {
        self.output.toggle()
    }
    
    var shape: any Shape {
        return Rectangle()
    }
    
    public func compute() {
        for outputConnection in outputConnections {
            outputConnection.value = output
        }
    }
}

extension InputComponent {
    
    var description: String {
        return """
        ID: \(id)
        Type: Input
        Output: \(self.output)
        Label: \(self.label)
        Outputs: \(self.outputConnections.compactMap({ "\($0.tail.label) | \($0.value)" }))
        """
    }
}
