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
                        
                        let controlPointX = (connection.head.position.x - connection.tail.position.x) / 4 + connection.tail.position.x // option 1
                        let controlPointY = (connection.head.position.y - connection.tail.position.y) + connection.tail.position.y
                        let controlPoint = CGPoint(x: controlPointX, y: controlPointY)
                        
                        let inputContact = connection.head.position.applying(.init(translationX: 50 + 20, y: 0))
                        var outputContact = connection.tail.position
                            
                        if connection.tail.inputConnections.count > 1 {
                            if let outputNum = connection.tail.inputConnections.firstIndex(where: { $0.connection?.id == connection.id }) {
                                outputContact = outputContact.applying(.init(translationX: -50 - 20, y: CGFloat((outputNum * 50) - 25)))
                            }
                        } else {
                            outputContact = outputContact.applying(.init(translationX: -70, y: 0))
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
    
    ORGate.moveTo(.init(x: 800, y: 300))
    Input.moveTo(.init(x: 200, y: 500))
    
    engine.connectComponent(ORGate, component2: Input, connector1: ORGate.inputConnections.first!, connector2: Input.outputConnections.first!)
    engine.add([ORGate, Input])
    
    return RendererView()
        .environmentObject(EditorContext())
        .environmentObject(engine)
}
