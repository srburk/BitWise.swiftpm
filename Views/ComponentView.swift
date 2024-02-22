//
//  ComponentView.swift
//
//
//  Created by Sam Burkhard on 2/7/24.
//

import SwiftUI

// I'm not sure that this will stay as a SwiftUI view. I have performance concerns over every component being its own view for larger projects

// reason components return this view and use their models to generate a shape and describe orientation of I/O. All Reason Components share some behaviors, like highlighting parts based on the editing mode and elligibility
struct ComponentView: View {
    
    @EnvironmentObject var editor: EditorContext
    
    var component: BaseReasonComponent
    
    @State private var isShowingPopoverView: Bool = false
    
    @State var position: CGPoint {
        didSet {
            component.position = position
        }
    }
    
    init(component: BaseReasonComponent, in canvas: CGSize) {
        self.component = component
        if component.position == .zero {
            self.position = CGPoint(x: canvas.width / 2, y: canvas.height / 2)
        } else {
            self.position = component.position
        }
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                editor.draggingComponent(component)
                self.position.x += value.translation.width
                self.position.y += value.translation.height
            }
    }
    
    private func wireContact(_ connector: ComponentConnector) -> some View {
        
        var color: Color = (editor.lastTappedWireContact?.id == connector.id && editor.mode == .wiring) ? .blue : Color.gray
        
        if editor.mode == .wiring && editor.selectedComponent?.id != self.component.id {
            color = editor.isValidWireContact(contact: connector) ? .green : .gray
        }
        
        return VStack {
            Circle()
                .frame(width: 20 * editor.canvasScale, height: 20 * editor.canvasScale)
                .foregroundStyle(color)
                .onTapGesture {
                    editor.tappedWireContact(component, contact: connector)
                }
        }
    }
    
    private var shapeColor: Color {
        var returnColor = Color(uiColor: .systemGray5)
        switch component.type {
            case .input:
                if let input = component as? InputComponent {
                    returnColor = (input.output) ? Color.green : Color.red
                }
            case .output:
                if let output = component as? OutputComponent {
                    returnColor = (output.output) ? Color.green : Color.red
                }
            case .other:
                break
        }
        return returnColor
    }
    
    var body: some View {
        
        ZStack {
            HStack(spacing: 10 * editor.canvasScale) {
                
                // inputs
                VStack(spacing: 25 * editor.canvasScale) {
                    ForEach(component.inputConnections, id: \.id) { connector in
                        wireContact(connector)
                    }
                }
                .frame(height: 55 * editor.canvasScale)
                
                component.shape.path(in: .init(x: 0, y: 0, width: 100 * editor.canvasScale, height: 100 * editor.canvasScale))
                    .frame(width: 100 * editor.canvasScale, height: 100 * editor.canvasScale)
                    .foregroundStyle(shapeColor)
                    .overlay {
                        if (editor.selectedComponent?.id == component.id) {
                            component.shape.path(in: .init(x: 0, y: 0, width: 100 * editor.canvasScale, height: 100 * editor.canvasScale))
                                .stroke(Color.blue, style: .init(lineWidth: 3, lineCap: .round, lineJoin: .bevel, miterLimit: 0.0, dash: [5, 10], dashPhase: 0.0))
                        }
                    }
                
                .onTapGesture {
                    editor.tappedComponent(component)
                }
                
                // outputs
                VStack(spacing: 25 * editor.canvasScale) {
                    ForEach(component.outputConnections, id: \.id) { connector in
                        wireContact(connector)
                    }
                }
                .frame(height: 55 * editor.canvasScale)
            }
            
//            Text("Group: \(component.processingGroup)")
//                .font(.caption)
            
        }

        .gesture(drag)
        .position(self.position)
    }
}

#Preview {
    GeometryReader { context in
        ComponentView(component: ORGate(label: "ORGatePreview"), in: context.size)
//        ComponentView(component: ORGate(label: "ORGatePreview"), position: .init(x: context.size.width / 2, y: context.size.height / 2))
            .environmentObject(EditorContext(engine: ReasonEngine(), canvasScale: 3.0))
    }
}
