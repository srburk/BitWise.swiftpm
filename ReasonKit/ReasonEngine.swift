//
//  ReasonEngine.swift
//
//
//  Created by Sam Burkhard on 2/1/24.
//

import Foundation
import SwiftUI

// engine for processing nodes
final class ReasonEngine: ObservableObject {
                
    // nodes stored with graph relationship
    @Published private(set) var nodes: [BaseReasonComponent] = []
    @Published private(set) var connections: [ReasonConnection] = []
    
    // nodes in processingGroups
    private(set) var queue: [Int: [BaseReasonComponent]] = [:]
}



extension ReasonEngine {
    
    /// automatically figure out which is input and which is output
    public func connectComponent(_ component1: BaseReasonComponent, component2: BaseReasonComponent, connector1: ComponentConnector, connector2: ComponentConnector) {
        if connector1.type != connector2.type {
            
            print("Connector 1 is \(connector1.type.rawValue)")
            print("Connector 2 is \(connector2.type.rawValue)")
            
            let inputComponent = (connector1.type == .input) ? component2 : component1
            let outputComponent = (connector1.type == .input) ? component1 : component2
            
            let newConnection = ReasonConnection(head: inputComponent, tail: outputComponent)
            
            connector1.connection = newConnection
            connector2.connection = newConnection
            
            self.connections.append(newConnection)
            Log.reason.log("Connection Formed from \(inputComponent.description) to \(outputComponent.description)")
            
        } else {
            Log.reason.error("Both connectors are the same type")
        }
    } 
//        if asInput {
//            if component.outputConnections.count < component.outputConnections.count && targetNode.inputConnections.count < targetNode.inputConnections.count {
//                let newConnection = ReasonConnection(head: component, tail: targetNode)
//                
//                component.outputConnections
//                component.outputConnections.append(newConnection)
//                targetNode.inputConnections.append(newConnection)
//                
//                self.connections.append(newConnection)
//            } else {
//                Log.reason.warning("\(component.id) can't be inputted in to \(targetNode.id)")
//            }
//        } else {
//            if component.inputConnections.count < component.inputCount && targetNode.outputConnections.count < targetNode.outputCount {
//                let newConnection = ReasonConnection(head: targetNode, tail: component)
//                component.inputConnections.append(newConnection)
//                targetNode.outputConnections.append(newConnection)
//                self.connections.append(newConnection)
//            } else {
//                Log.reason.warning("\(targetNode.id) can't be inputted in to \(component.id)")
//            }
//        }
//    }
    
//    public func connectComponent(_ component: BaseReasonComponent, to targetNodes: [BaseReasonComponent], asInputs: Bool = false) {
//        for node in targetNodes {
//            self.connectComponent(component, to: node, asInput: asInputs)
//        }
//    }
    
    // go through queue and compute
    public func compute() {
        for group in queue.keys.sorted() {
            print("Group \(group):")
            for node in queue[group] ?? [] {
                node.compute()
            }
        }
    }
    
    public func printInOrder() {
        print("Sorted Nodes:")
        for group in queue.keys.sorted() {
            print("Group \(group):")
            for node in queue[group] ?? [] {
                print(node)
            }
        }
    }
    
    /// gives each node the correct processingGroup label
    public func orderNodes() {
        
        var visited = Set<UUID>()
        // TODO: Only reset relevant groups
        self.queue = [:]
        
        func traverseNode(_ node: BaseReasonComponent, level: Int) {
            
            // TODO: Need to check if visited that the stored level is the same. Stick with the higher one
            
            if !visited.contains(node.id) || node.processingGroup < level {
                
                visited.insert(node.id)

                node.processingGroup = level
                
                for child in node.outputConnections.compactMap({ $0.connection }) {
                    traverseNode(child.tail, level: level + 1)
                }
            }
            return
        }
        
        // this can be changed to an input to use some level of logic to recalculate based on what group actually had a change
        let rootNodes = self.nodes.filter({ $0.inputConnections.count == 0 })
        
        for node in rootNodes {
            traverseNode(node, level: 0)
        }
        
        for node in nodes {
            if queue.keys.contains(where: { $0 == node.processingGroup }) {
                // group exists
                queue[node.processingGroup]?.append(node)
            } else {
                // group doesn't exist
                queue[node.processingGroup] = [node]
            }
        }
    }
    
    public func add(_ component: BaseReasonComponent) {
        guard !self.nodes.contains(where: { $0.id == component.id }) else {
            Log.reason.warning("Can't add duplicate of component \(component.id.uuidString)")
            return
        }
        self.nodes.append(component)
        Log.reason.log("Added component \(String(describing: component))")
    }
    
    public func add(_ components: [BaseReasonComponent]) {
        for component in components {
            self.add(component)
        }
    }
    
    public func removeConnection(_ connection: ReasonConnection) {
        if let connectionIndex = self.connections.firstIndex(where: { $0.id == connection.id }) {
            self.connections.remove(at: connectionIndex)
            let input = connection.tail.inputConnections.first(where: { $0.connection?.id == connection.id })
            input?.connection = nil
            let output = connection.head.outputConnections.first(where: { $0.connection?.id == connection.id })
            output?.connection = nil
        } else {
            Log.reason.error("Connection \(connection.id) does not exist")
        }
    }
    
//    public func remove(_ component: BaseReasonComponent) {
//        
//        for inputConnection in component.inputConnections {
//            self.removeConnection(inputConnection)
//        }
//        
//        for outputConnection in component.outputConnections {
//            self.removeConnection(outputConnection)
//        }
//        
//        Log.reason.log("removed node: \(component.label)")
//        if let index = nodes.firstIndex(where: { $0.id == component.id }) {
//            self.nodes.remove(at: index)
//            Log.reason.log("Removed component \(String(describing: component))")
//        } else {
//            Log.reason.warning("Can't remove component that doesn't exist: \(component.label)")
//        }
//    }
    
//    public func remove(_ components: [BaseReasonComponent]) {
//        for component in components {
//            self.remove(component)
//        }
//    }
    
    // for testing purposes, be very careful
    public func removeAll() {
        self.nodes.removeAll()
        self.connections.removeAll()
    }
    
}

// MARK: Renderer functions
//extension ReasonEngine {
//    public func componentAtPoint(_ point: CGPoint) -> BaseReasonComponent? {
//
//        let localizedPoint = point.applying(.init(scaleX: 1/self.canvasScale, y: 1/self.canvasScale))
//        if let tappedObject = self.nodes.first(where: { object in
//            let horizontal = (localizedPoint.x >= object.location.x) && (localizedPoint.x <= object.location.x + object.size.width)
//            let vertical = (localizedPoint.y >= object.location.y) && (localizedPoint.y <= object.location.y + object.size.height)
//            return horizontal && vertical
//        }) {
//            return tappedObject
//        } else {
//            return nil
//        }
//    }
    
//    public func mappedComponent(_ component: BaseReasonComponent, with context: GraphicsContext) -> Path {
//
//        let transform = CGAffineTransform(translationX: component.location.x, y: component.location.y)
//        let scaler = CGAffineTransform(scaleX: self.canvasScale, y: self.canvasScale)
//
//        return (component.shape.path(in: CGRect(x: 0, y: 0, width: component.size.width, height: component.size.height)).applying(transform).applying(scaler))
//    }
    
//    public func update(date: Date) { }
//
//    public func dragObject(to value: DragGesture.Value) {
//
//        for object in self.nodes {
//            object.location = object.location.applying(.init(translationX: value.translation.width, y: value.translation.height))
//        }
//    }
//
//    public func dragComponent(_ component: BaseReasonComponent, to value: DragGesture.Value) {
//        component.location.x += value.translation.width / self.canvasScale
//        component.location.y += value.translation.height / self.canvasScale
//    }
//}
