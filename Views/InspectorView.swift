//
//  InspectorView.swift
//
//
//  Created by Sam Burkhard on 2/6/24.
//

import SwiftUI

/// This view should adapt to a floating window depending on if the ipad is in slideover? Do I want to have slideover as an option? I think it might be nice but then I'm basically supporting an iphone size

// I think a floating window would look better anyways
struct InspectorView: View {
    
    @EnvironmentObject var engine: ReasonEngine
    @EnvironmentObject var editor: EditorContext
    
    var proxy: GeometryProxy
    
    var body: some View {
        
        HStack(spacing: 0) {
            Divider()
            
            ZStack {
                Color(uiColor: .systemGray6)
            
                ScrollView(.vertical) {
                    
                    VStack(spacing: 25) {
                        
                        Button {
                            engine.add(InputComponent(label: "FirstInput"))
                        } label: {
                            Text("Add Input")
                        }
                        
                        Button {
                            engine.add(ORGate(label: "TestORGate"))
                        } label: {
                            Text("Add OR Gate")
                        }
                        
                        Button {
                            engine.add(ANDGate(label: "TestANDGate"))
                        } label: {
                            Text("Add AND Gate")
                        }
                        
                        if editor.selectedComponent != nil {
                            VStack {
                                Text("\(editor.selectedComponent?.id.uuidString ?? "None")")
                            }
                        }
                    }
                }
                .padding()
            }
            .frame(width: proxy.size.width * 0.2)
        }
    }
}

#Preview {
    GeometryReader { proxy in
        HStack(spacing: 0) {
            Spacer()
            InspectorView(proxy: proxy)
        }
    }
    .ignoresSafeArea(.all, edges: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
}
