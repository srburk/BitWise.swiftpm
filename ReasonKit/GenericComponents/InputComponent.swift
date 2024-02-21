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
    
    var inputConnections: [ComponentConnector] = []
    var outputConnections: [ComponentConnector] = [.output]
        
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
    
    public func compute() {
        for outputConnection in outputConnections {
            outputConnection.setValue(self.output)
        }
    }
    
    var type: ReasonComponentType = .input
    
    var shape: any Shape {
        struct Input: Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()
                let width = rect.size.width
                let height = rect.size.height
                path.move(to: .zero)
                path.addLine(to: .init(x: width, y: 0))
                path.addLine(to: .init(x: width, y: height))
                path.addLine(to: .init(x: 0, y: height))
                path.closeSubpath()
                
                return path
            }
            
        }
        return Input()
    }
    var position: CGPoint = .zero
}

extension InputComponent {
    
    func moveTo(_ point: CGPoint) {
        self.position = point
    }
    
    var description: String {
        return "Input"
//        ID: \(id)
//        Type: Input
//        Output: \(self.output)
//        Label: \(self.label)
//        Outputs: \(self.outputConnections.compactMap({ "\($0.tail.label) | \($0.value)" }))
//        """
    }
}
