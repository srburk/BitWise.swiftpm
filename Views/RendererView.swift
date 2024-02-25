//
//  RendererView.swift
//
//
//  Created by Sam Burkhard on 2/7/24.
//

import Foundation
import SwiftUI

struct RendererView: View {
    
    @EnvironmentObject var engine: ReasonEngine
    @EnvironmentObject var editor: EditorContext
    
    var body: some View {
        
        // composite view of pencil layer, text layer, and component layer, in that order
        VStack {
                        
            GeometryReader { context in
                
                ForEach(engine.connections, id: \.id) { connection in
                    Path { path in
                        
                        let controlPointX = (connection.tail.position.x -  connection.head.position.x) / 4 + connection.head.position.x // option 1
                        let controlPointY = (connection.tail.position.y - connection.head.position.y) + connection.head.position.y
                        let controlPoint = CGPoint(x: controlPointX, y: controlPointY)
                        
                        let inputContact = connection.head.position.applying(.init(translationX: 60, y: 0))
                        var outputContact = connection.tail.position
                            
                        if connection.tail.inputConnections.count > 1 {
                            if let outputNum = connection.tail.inputConnections.firstIndex(where: { $0.connection.contains(where: { $0.id == connection.id }) }) {
                                outputContact = outputContact.applying(.init(translationX: -70, y: CGFloat((outputNum * 50) - 25)))
                            }
                        } else {
                            outputContact = outputContact.applying(.init(translationX: -60, y: 0))
                        }
                        path.move(to: inputContact)
                        path.addQuadCurve(to: outputContact, control: controlPoint)
                    }
                    .stroke((connection.value) ? .green : .gray, style: .init(lineWidth: 5, lineCap: .round, lineJoin: .round, miterLimit: 0.0, dash: [], dashPhase: 0))
                }
                
                ForEach(engine.nodes, id: \.id) { component in
                    ComponentView(component: component, in: context.size)
                }
            }
            .drawingGroup() // high performance drawing
        }
    }
}

#Preview {
    
    let engine = ReasonEngine()
    
    let ORGate = ORGate()
    let Input = InputComponent()
    let Output = OutputComponent(position: .init(x: 1050, y: 500))
    
    ORGate.moveTo(.init(x: 800, y: 450))
    Input.moveTo(.init(x: 600, y: 500))
    
    engine.connectComponent(ORGate, component2: Input, connector1: ORGate.inputConnections.first!, connector2: Input.outputConnections.first!)
    engine.connectComponent(ORGate, component2: Output, connector1: ORGate.outputConnections.first!, connector2: Output.inputConnections.first!)
        
    engine.add([ORGate, Input, Output])
    
    return RendererView()
        .environmentObject(EditorContext())
        .environmentObject(engine)
}
