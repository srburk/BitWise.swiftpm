//
//  ReasonComponent.swift
//
//
//  Created by Sam Burkhard on 2/1/24.
//

import Foundation
import SwiftUI

enum ReasonComponentType {
    case input, output, other
}

protocol BaseReasonComponent: AnyObject, CustomStringConvertible {
    
    var id: UUID { get }
    
    var inputConnections: [ComponentConnector] { get set }
    var outputConnections: [ComponentConnector] { get set }
    
    var processingGroup: Int { get set } // having this stored in the node makes it easier to determine what group should have a change when connecting new child nodes
    
    init(position: CGPoint)
    
    func compute()
    
    // Visuals - TODO: refactor later
    var shape: any Shape { get }
    var position: CGPoint { get set }
    var type: ReasonComponentType { get }
}

// MARK: Moving these to the engine
//extension BaseReasonComponent {
//    
//    // connect utilities - returns reference to self to chain after creating variable
//    public func connect(to targetNode: BaseReasonComponent, asInput: Bool = false) -> 
//    
//        BaseReasonComponent {
//        
//        if asInput {
//            if self.outputConnections.count < self.outputCount && targetNode.inputConnections.count < targetNode.inputCount {
//                let newConnection = ReasonConnection(head: self, tail: targetNode)
//                self.outputConnections.append(newConnection)
//                targetNode.inputConnections.append(newConnection)
//            } else {
//                Log.reason.warning("\(self.id) can't be inputted in to \(targetNode.id)")
//            }
//        } else {
//            if self.inputConnections.count < self.inputCount && targetNode.outputConnections.count < targetNode.outputCount {
//                let newConnection = ReasonConnection(head: targetNode, tail: self)
//                self.inputConnections.append(newConnection)
//                targetNode.outputConnections.append(newConnection)
//            } else {
//                Log.reason.warning("\(targetNode.id) can't be inputted in to \(self.id)")
//            }
//        }
//        
//        return self
//    }
//    
//    public func connect(to targetNodes: [BaseReasonComponent], asInputs: Bool = false) -> BaseReasonComponent {
//        for node in targetNodes {
//            _ = self.connect(to: node, asInput: asInputs)
//        }
//        return self
//    }
//    
//    // disconnect utilities
//    public func cleanForRemoval() {
//        
//        for inputConnection in self.inputConnections {
//            inputConnection.removeConnections()
//        }
//        
//        for outputConnection in self.outputConnections {
//            outputConnection.removeConnections()
//        }
//        
//        Log.reason.log("removed node: \(self.label)")
//    }
//}
