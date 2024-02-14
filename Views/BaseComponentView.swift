//
//  BaseComponentView.swift
//
//
//  Created by Sam Burkhard on 2/7/24.
//

import SwiftUI

// I'm not sure that this will stay as a SwiftUI view. I have performance concerns over every component being its own view for larger projects

// reason components return this view and use their models to generate a shape and describe orientation of I/O. All Reason Components share some behaviors, like highlighting parts based on the editing mode and elligibility
struct BaseComponentView: View {
    
    @EnvironmentObject var editor: EditorContext
    
    @State private var position: CGPoint = .zero
    @GestureState private var startLocation: CGPoint? = nil // 1

    var component: BaseReasonComponent
    
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                var newLocation = startLocation ?? position // 3
                newLocation.x += value.translation.width
                newLocation.y += value.translation.height
                self.position = newLocation
            }
//            .updating($startLocation) { (value, startLocation, transaction) in
//                startLocation = startLocation ?? position // 2
//            }
    }
    
    var body: some View {
//        VStack {
            
            Text(component.label)
            
//        component.shape.path(in: .init(origin: .init(x: 40, y: 50), size: .init(width: 100, height: 100)))
//                .stroke(lineWidth: 4)
//                .foregroundStyle(.clear)
            
//        }
        .padding()
        .frame(width: 120, height: 120)
        .border((editor.selectedComponent?.id == component.id) ? Color.green : Color.blue, width: 3)
        
        .onTapGesture {
            editor.tappedComponent(component)
        }
        
        .gesture(simpleDrag)
        .position(self.position)
        
    }
}

#Preview {
    BaseComponentView(component: ORGate(label: "ORGatePreview"))
        .environmentObject(EditorContext())
}
