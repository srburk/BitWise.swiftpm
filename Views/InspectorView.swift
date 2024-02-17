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
        
        HStack {
            Spacer()
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 15, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                    .strokeBorder(Color(uiColor: .systemGray3), lineWidth: 0.5)
                    .background(RoundedRectangle(cornerRadius: 15, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/).foregroundStyle(Color(.sRGB, red: 0.97, green: 0.97, blue: 0.97)))
//                    .foregroundStyle(Color(uiColor: .systemGray6))
            
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
                        
                        VStack {
                            Text("Nodes:")
                            
                            ForEach(engine.nodes, id: \.id) { node in
                                Text(node.label)
                                    .font(.caption)
                            }
                        }
                        
                        VStack {
                            Text("Connections:")
                            
                            ForEach(engine.connections, id: \.id) { connection in
                                Text("\(connection.head.label) -> \(connection.tail.label)")
                                    .font(.caption)
                            }
                        }
                        
                        if editor.selectedComponent != nil {
                            VStack {
                                Text("Selected Component: ")
                                Text("\(editor.selectedComponent?.id.uuidString ?? "None")")
                                    .font(.caption)
                            }
                        }
                    }
                }
                .padding()
            }
            .frame(width: proxy.size.width * 0.2)
            .padding(15)
        }
    }
}

#Preview {
    
    let engine = ReasonEngine()
    
    return GeometryReader { proxy in
        InspectorView(proxy: proxy)
            .environmentObject(engine)
            .environmentObject(EditorContext(engine: engine))
    }
    .ignoresSafeArea(.all, edges: .bottom)
    .toolbarBackground(.visible, for: .navigationBar)
}
