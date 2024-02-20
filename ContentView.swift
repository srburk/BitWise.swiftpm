import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var engine: ReasonEngine
    @EnvironmentObject var editor: EditorContext
    
    var body: some View {
        
        NavigationStack {
            
            GeometryReader { proxy in
                    
                RendererView()
                
                if editor.showingInspectorView {
                    InspectorView(proxy: proxy)
                        .transition(.move(edge: .trailing))
                }
                
            }
            .ignoresSafeArea(.all, edges: .bottom)
            
            .toolbar {
                
                ToolbarItemGroup(placement: .topBarLeading) {
                    Text("Editor Mode: \(editor.mode.rawValue)")
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    
                    Button {
                        engine.orderNodes()
                        engine.compute()
                    } label: {
                        Image(systemName: "play.fill")
                    }
                    
                    Button {
                        withAnimation {
                            editor.showingInspectorView.toggle()
                        }
                    } label: {
                        Image(systemName: "wrench.and.screwdriver.fill")
                            .padding(5)
                            .foregroundStyle(editor.showingInspectorView ? .white : .blue)
                            .background(RoundedRectangle(cornerRadius: 8, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/).foregroundStyle(editor.showingInspectorView ? .blue : .clear))
                    }
                    
                    Button {
                        // show inspector view
                    } label: {
                        Image(systemName: "info.circle")
                            .padding(5)
                            .foregroundStyle(editor.showingInspectorView ? .white : .blue)
                            .background(RoundedRectangle(cornerRadius: 8, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/).foregroundStyle(editor.showingInspectorView ? .blue : .clear))
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
