import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var engine: ReasonEngine
    @EnvironmentObject var editor: EditorContext
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView(.horizontal) {
                VStack {
                    Spacer()
                    HStack {
                        ForEach(engine.nodes, id: \.id) { node in
                            Text(node.description)
                                .padding()
                                .border(Color.black)
                                .onTapGesture {
                                    editor.changeMode(to: .wiring)
                                }
                        }
                    }
                    Spacer()
                }
                
            }
            
            .toolbar {
                
                ToolbarItemGroup(placement: .topBarLeading) {
                    Text("Editor Mode: \(editor.mode.rawValue)")
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    
                    Button {
                        engine.orderNodes()
                    } label: {
                        Image(systemName: "play.fill")
                    }
                    
                    Button {
                        engine.add(ORGate(label: "TestORGate"))
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            
//            .toolbar(id: "customizable") {
//                
//                ToolbarItem(id: "test", placement: .secondaryAction) {
//                    Text("Test")
//                }
                
//                ToolbarItem(id: "intiallyHidden", placement: .secondaryAction, showsByDefault: false) {
//                    Text("Hidden Initially")
//                }
//            }
            .toolbarRole(.editor)
            .toolbarBackground(.visible, for: .navigationBar)

        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ReasonEngine())
}
