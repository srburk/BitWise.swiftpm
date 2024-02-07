//
//  ReasonEngine.swift
//
//
//  Created by Sam Burkhard on 2/1/24.
//

import Foundation

// global engine for processing nodes
final class ReasonEngine {
    
    static let shared = ReasonEngine()
        
    // nodes stored with graph relationship
    public var nodes: [BaseReasonComponent] = []
    
    // nodes in processingGroups
    private(set) var queue: [Int: [BaseReasonComponent]] = [:]

}

extension ReasonEngine {
    
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
                
                for child in node.outputConnections {
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
            Log.reason.warning("Can't add duplicate of component \(component.label)")
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
    
}
