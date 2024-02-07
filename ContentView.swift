import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var engine: ReasonEngine
    @EnvironmentObject var editor: EditorContext
    
    var body: some View {
        
        NavigationStack {
            
            GeometryReader { proxy in
                
                HStack {
                    ScrollView(.horizontal) {
                        VStack {
                            Spacer()
                            HStack {
                                ForEach(engine.nodes, id: \.id) { node in
                                    BaseComponentView(component: node)
                                }
                            }
                            Spacer()
                        }
                    }
                    
                    InspectorView(proxy: proxy)
                    
                }
                
            }
            .ignoresSafeArea(.all, edges: .bottom)
            
            .toolbar {
                
                ToolbarItemGroup(placement: .topBarLeading) {
                    Text("Editor Mode: \(editor.mode.rawValue)")
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    
                    Button {
                        // this should be a different mechanism for when we're in placement mode, for now I just have it as wiring to make connections easier
                        if editor.selectedComponent != nil {
                            editor.selectedComponent!.cleanForRemoval()
                            engine.remove(editor.selectedComponent!)
                            editor.selectedComponent = nil
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
