//
//  ANDGate.swift
//
//
//  Created by Sam Burkhard on 2/1/24.
//

import Foundation
import SwiftUI

class ANDGate: BaseReasonComponent {
    
    var id: UUID
    var label: String
        
    var inputConnections: [ComponentConnector]
    var outputConnections: [ComponentConnector]
    var processingGroup: Int
        
    required init(label: String) {
        self.id = UUID()
        self.label = label
        
        self.inputConnections = [.input, .input]
        self.outputConnections = [.output]
        
        self.processingGroup = 0
    }
    
    func compute() {
        
        let value = inputConnections.allSatisfy { $0.value }
        
        for outputConnection in self.outputConnections {
            outputConnection.setValue(value)
        }
    }
    
    var type: ReasonComponentType = .other
    
    var shape: any Shape {
        struct And: Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()
                let width = rect.size.width
                let height = rect.size.height
                path.move(to: CGPoint(x: 0, y: 0.03788*height))
                path.addCurve(to: CGPoint(x: 0.03521*width, y: 0), control1: CGPoint(x: 0, y: 0.01696*height), control2: CGPoint(x: 0.01576*width, y: 0))
                path.addLine(to: CGPoint(x: 0.54225*width, y: 0))
                path.addCurve(to: CGPoint(x: width, y: 0.49242*height), control1: CGPoint(x: 0.79506*width, y: 0), control2: CGPoint(x: width, y: 0.22047*height))
                path.addLine(to: CGPoint(x: width, y: 0.50758*height))
                path.addCurve(to: CGPoint(x: 0.54225*width, y: height), control1: CGPoint(x: width, y: 0.77954*height), control2: CGPoint(x: 0.79506*width, y: height))
                path.addLine(to: CGPoint(x: 0.03521*width, y: height))
                path.addCurve(to: CGPoint(x: 0, y: 0.96212*height), control1: CGPoint(x: 0.01576*width, y: height), control2: CGPoint(x: 0, y: 0.98304*height))
                path.addLine(to: CGPoint(x: 0, y: 0.4697*height))
                path.addLine(to: CGPoint(x: 0, y: 0.03788*height))
                path.closeSubpath()
                return path
            }
        }
        return And()
    }
    var position: CGPoint = .zero
}

extension ANDGate {
    var description: String {
        return "And Gate"
//        ID: \(id)
//        Type: AND Gate
//        Label: \(self.label)
//        InputCount: \(self.inputCount)
//        OutputCount: \(self.outputCount)
//        Inputs: \(self.inputConnections.compactMap({ "\($0.head.label) | \($0.value)" }))
//        Outputs: \(self.outputConnections.compactMap({ "\($0.tail.label) | \($0.value)" }))
//        ProcessingGroup: \(self.processingGroup)
//        """
    }
}
