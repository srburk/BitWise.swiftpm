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
    
    @State var position: CGPoint {
        didSet {
            component.position = position
        }
    }
    
    init(component: BaseReasonComponent) {
        self.component = component
        self.position = component.position
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                editor.draggingComponent(component)
                self.position.x += value.translation.width
                self.position.y += value.translation.height
            }
    }
    
    private var inputWireContact: some View {
        Rectangle()
            .frame(width: 20 * editor.canvasScale, height: 20 * editor.canvasScale)
            .foregroundStyle(.red)
            .onTapGesture {
                editor.tappedWireContact(component, wireContactIsInput: true)
            }
    }
    
    private var outputWireContact: some View {
        Rectangle()
            .frame(width: 20 * editor.canvasScale, height: 20 * editor.canvasScale)
            .foregroundStyle(.blue)
            .onTapGesture {
                editor.tappedWireContact(component, wireContactIsInput: false)
            }
    }
    
    var body: some View {
        
        ZStack {
            
            HStack(spacing: 10 * editor.canvasScale) {
                
                // inputs
                VStack(spacing: 25 * editor.canvasScale) {
                    ForEach(0..<component.inputCount, id: \.self) { connection in
                        inputWireContact
                    }
                }
                .frame(height: 55 * editor.canvasScale)
                
                component.shape.path(in: .init(x: 0, y: 0, width: 100 * editor.canvasScale, height: 100 * editor.canvasScale))
                    .frame(width: 100 * editor.canvasScale, height: 100 * editor.canvasScale)
                    .foregroundStyle(.gray)
                
                .onTapGesture {
                    editor.tappedComponent(component)
                }
                
                // outputs
                VStack(spacing: 25 * editor.canvasScale) {
                    ForEach(0..<component.outputCount, id: \.self) { num in
                        outputWireContact
                    }
                }
                .frame(height: 55 * editor.canvasScale)
            }
            
            Text("Group: \(component.processingGroup)")
                .font(.caption)
            
        }
        .gesture(drag)
        .position(self.position)
    }
}

#Preview {
    GeometryReader { context in
        ComponentView(component: ORGate(label: "ORGatePreview"))
//        ComponentView(component: ORGate(label: "ORGatePreview"), position: .init(x: context.size.width / 2, y: context.size.height / 2))
            .environmentObject(EditorContext(engine: ReasonEngine(), canvasScale: 3.0))
    }
}
