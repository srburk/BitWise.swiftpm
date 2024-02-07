//
//  File.swift
//  
//
//  Created by Sam Burkhard on 2/6/24.
//

import Foundation

class OutputComponent: BaseReasonComponent {
        
    var id: UUID
    var label: String
    
    var inputConnections: [ReasonConnection] = []
    var outputConnections: [ReasonConnection] = []
    
    var output: Bool = true // this is the special output component interaction (shared with inputcomponent)
    
    var processingGroup: Int = 0
    
    required init(label: String) {
        self.id = UUID()
        self.label = label
    }
    
    public func compute() {
        self.output = inputConnections.contains(where: { $0.value })
    }
}

extension OutputComponent {
    
    var description: String {
        return """

        =======================
        ID: \(id)
        Type: Output
        Label: \(self.label)
        Inputs: \(self.inputConnections.compactMap({ "\($0.head.label) | \($0.value)" }))
        =======================
        """
    }
}
