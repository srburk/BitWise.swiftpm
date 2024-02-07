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
    
    var component: BaseReasonComponent
    
    var body: some View {
        VStack {
            
            Text(component.description)
            
            HStack {
                
                Button {
                    
                } label: {
                    Text("Add Input")
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Add Output")
                }
                
            }
            .padding()
            
        }
        .padding()
        .border((editor.selectedComponent?.id == component.id) ? Color.blue : Color.primary, width: 3)
        
        .onTapGesture {
            editor.tappedComponent(component)
        }
    }
}

#Preview {
    BaseComponentView(component: ORGate(label: "ORGatePreview"))
        .environmentObject(EditorContext())
}
