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
    
    @ViewBuilder
    private func addComponentCell(text: String, shape: any Shape, action: @escaping () -> Void) -> some View {
        
        Button {
            action()
        } label: {
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                Text(text)
                    .font(.headline)
                Spacer()
                shape.path(in: .init(x: 0, y: 0, width: 30, height: 30))
                    .fill(Color.gray)
                    .frame(width: 30, height: 30)
            }
            .padding(10)
            .background(Color(uiColor: .systemGray5), in: RoundedRectangle(cornerRadius: 10))
        }
        .buttonStyle(.plain)
    }
    
    var body: some View {
        
        HStack {
            Spacer()
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 15, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                    .strokeBorder(Color(uiColor: .systemGray3), lineWidth: 0.5)
                    .background(RoundedRectangle(cornerRadius: 15, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/).foregroundStyle(Color(.sRGB, red: 0.97, green: 0.97, blue: 0.97)))

                ScrollView(.vertical) {
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("Add Components")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        
                        addComponentCell(text: "Input", shape: Rectangle()) {
                            engine.add(InputComponent(label: "Input"))
                        }
                        
                        addComponentCell(text: "Output", shape: Rectangle()) {
                            engine.add(OutputComponent(label: "Output"))
                        }
                        
                        addComponentCell(text: "AND Gate", shape: ANDShape()) {
                            engine.add(ANDGate(label: "AndGate"))
                        }
                        
                        addComponentCell(text: "OR Gate", shape: ORShape()) {
                            engine.add(ORGate(label: "ORGate"))
                        }
                        
                        addComponentCell(text: "NOT Gate", shape: NOTShape()) {
                            engine.add(NOTGate(label: "NOTGate"))
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
