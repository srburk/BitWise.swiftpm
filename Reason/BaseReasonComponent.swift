//
//  ReasonComponent.swift
//
//
//  Created by Sam Burkhard on 2/1/24.
//

import Foundation

class BaseReasonComponent: CustomStringConvertible {
    
    var id: UUID
    var label: String
    var inputConnections: [ReasonConnection] = []
    var outputConnections: [ReasonConnection] = []
    
    var processingGroup: Int = 0 // having this stored in the node makes it easier to determine what group should have a change when connecting new child nodes
    
    var computeLogic: (() -> Bool)
    
    required init(label: String, computeLogic: @escaping (() -> Bool)) {
        self.id = UUID()
        self.label = label
        self.computeLogic = computeLogic
    }
    
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

extension BaseReasonComponent {
    
    public func compute() {
        
    }
    
    // connect utilities - returns reference to self to chain after creating variable
    public func connect(to targetNode: BaseReasonComponent, asInput: Bool = false) -> BaseReasonComponent {
        
        if asInput {
            let newConnection = ReasonConnection(head: self, tail: targetNode)
            self.outputConnections.append(newConnection)
            targetNode.inputConnections.append(newConnection)
        } else {
            let newConnection = ReasonConnection(head: targetNode, tail: self)
            self.inputConnections.append(newConnection)
            targetNode.outputConnections.append(newConnection)
        }
        
        return self
    }
    
    public func connect(to targetNodes: [BaseReasonComponent], asInputs: Bool = false) -> BaseReasonComponent {
        for node in targetNodes {
            _ = self.connect(to: node, asInput: asInputs)
        }
        return self
    }
    
    // disconnect utilities
    public func disconnect(from targetNode: BaseReasonComponent) -> BaseReasonComponent {
        Log.reason.warning("⚠️ BaseReasonComponent.disconnect() not implemented")
        return self
    }
    
    public func add() -> BaseReasonComponent {
        ReasonEngine.shared.add(self)
        return self
    }
    
}
