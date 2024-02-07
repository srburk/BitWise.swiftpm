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
                                .border(Color.primary)
                                .onTapGesture {
                                    editor.tappedComponent(node)
                                }
                        }
                    }
                    Spacer()
                }
                
            }
            
            .toolbar {
                
                ToolbarItemGroup(placement: .topBarLeading) {
                    Text("Editor Mode: \(editor.mode.rawValue)")
                    Text("LastTapped: \(editor.lastTouchedComponent?.description ?? "None")")
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    
                    Button {
                        // this should be a different mechanism for when we're in placement mode, for now I just have it as wiring to make connections easier
                        if editor.lastTouchedComponent != nil {
                            editor.lastTouchedComponent!.cleanForRemoval()
                            engine.remove(editor.lastTouchedComponent!)
                            editor.lastTouchedComponent = nil
                        }
                    } label: {
                        Image(systemName: "trash.fill")
                    }
                    
                    Button {
                        engine.orderNodes()
                        engine.compute()
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
