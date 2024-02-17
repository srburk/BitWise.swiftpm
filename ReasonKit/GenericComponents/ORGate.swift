//
//  ORGate.swift
//  
//
//  Created by Sam Burkhard on 2/1/24.
//

import Foundation
import SwiftUI

class ORGate: BaseReasonComponent {
    
    var id: UUID
    
    var label: String
    
    var inputCount: Int = 2
    var outputCount: Int = 1
    
    var inputConnections: [ReasonConnection]
    var outputConnections: [ReasonConnection]
    var processingGroup: Int
        
    required init(label: String) {
        self.id = UUID()
        self.label = label
        self.inputConnections = []
        self.outputConnections = []
        self.processingGroup = 0
    }
    
    deinit {
        // testing to make sure things are freed when they need to be
        Log.reason.warning("Deinitialized component: \(self.id)")
    }

    func compute() {
        
        let value = inputConnections.contains(where: { $0.value })

        // there could be more logic for this based on what kind of output should exist
        for outputConnection in self.outputConnections {
            outputConnection.value = value
        }
    }
    
    var shape: any Shape {
        struct OR: Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()
                let width = rect.size.width
                let height = rect.size.height
                path.move(to: CGPoint(x: 0.00826*width, y: 0.05457*height))
                path.addCurve(to: CGPoint(x: 0.00429*width, y: 0.01975*height), control1: CGPoint(x: 0.00284*width, y: 0.04361*height), control2: CGPoint(x: -0.00124*width, y: 0.03064*height))
                path.addCurve(to: CGPoint(x: 0.03521*width, y: 0), control1: CGPoint(x: 0.01026*width, y: 0.00798*height), control2: CGPoint(x: 0.02187*width, y: 0))
                path.addLine(to: CGPoint(x: 0.54225*width, y: 0))
                path.addCurve(to: CGPoint(x: width, y: 0.49242*height), control1: CGPoint(x: 0.79506*width, y: 0), control2: CGPoint(x: width, y: 0.22047*height))
                path.addLine(to: CGPoint(x: width, y: 0.50758*height))
                path.addCurve(to: CGPoint(x: 0.54225*width, y: height), control1: CGPoint(x: width, y: 0.77954*height), control2: CGPoint(x: 0.79506*width, y: height))
                path.addLine(to: CGPoint(x: 0.03521*width, y: height))
                path.addCurve(to: CGPoint(x: 0.00454*width, y: 0.98073*height), control1: CGPoint(x: 0.02205*width, y: height), control2: CGPoint(x: 0.01058*width, y: 0.99223*height))
                path.addCurve(to: CGPoint(x: 0.00872*width, y: 0.94507*height), control1: CGPoint(x: -0.0013*width, y: 0.96963*height), control2: CGPoint(x: 0.003*width, y: 0.95626*height))
                path.addLine(to: CGPoint(x: 0.0965*width, y: 0.77337*height))
                path.addCurve(to: CGPoint(x: 0.09991*width, y: 0.2398*height), control1: CGPoint(x: 0.18129*width, y: 0.60753*height), control2: CGPoint(x: 0.18257*width, y: 0.40687*height))
                path.addLine(to: CGPoint(x: 0.00826*width, y: 0.05457*height))
                path.closeSubpath()
                return path
            }
        }
        return OR()
    }
    var position: CGPoint = .zero
}

extension ORGate {
    var description: String {
        return """
        ID: \(id)
        Type: OR Gate
        Label: \(self.label)
        InputCount: \(self.inputCount)
        OutputCount: \(self.outputCount)
        Inputs: \(self.inputConnections.compactMap({ "\($0.head.label) | \($0.value)" }))
        Outputs: \(self.outputConnections.compactMap({ "\($0.tail.label) | \($0.value)" }))
        ProcessingGroup: \(self.processingGroup)
        """
    }
}
