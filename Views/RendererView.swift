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
    
//    @State private var position: CGPoint = .zero

    // drag operation changes based on editor context
//    var drag: some Gesture {
//        DragGesture(coordinateSpace: .global)
//            .onChanged { value in
//                if editor.mode == .placement && editor.selectedComponent != nil {
//                    engine.renderer?.dragComponent(editor.selectedComponent!, to: value)
//                }
//                engine.dragObject(to: value)
//                self.position.x += value.translation.width
//                self.position.y += value.translation.height
//            }
//    }
    
    var body: some View {
        
        // composite view of pencil layer, text layer, and component layer, in that order
        VStack {
            ZStack {
                ForEach(engine.nodes, id: \.id) { component in
                    ComponentView(component: component)
                }
                Path { path in
                    for connection in engine.connections {
                        path.move(to: connection.head.position)
                        path.addLine(to: connection.tail.position)
                    }
                }.stroke(Color.green, lineWidth: 10)

            }
            .drawingGroup() // high performance drawing
            
            Spacer()
            Slider(value: $editor.canvasScale, in: 0.25...3)
                .padding(.bottom)
        }
    }
}

#Preview {
    
    let engine = ReasonEngine()
    
    let ORGate = ORGate(label: "ORGate")
    let Input = InputComponent(label: "Input")
    
    engine.connectComponent(ORGate, to: Input)
    engine.add([ORGate, Input])
    
    return RendererView()
        .environmentObject(EditorContext(engine: engine))
        .environmentObject(engine)
}
