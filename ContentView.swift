import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var engine: ReasonEngine
    @EnvironmentObject var editor: EditorContext
        
    var body: some View {
        
        NavigationStack {
            
            GeometryReader { proxy in
                
                HStack(spacing: 0) {
                    if editor.showingLessonView && !editor.currentlySelectedLesson.slides.isEmpty {
                        LessonView(proxy: proxy)
                            .transition(.move(edge: .leading))
                    }

                    ZStack {
                        RendererView()
                            .zIndex(1.0)
                        
                        PencilView()
                            .zIndex((editor.mode == .drawing) ? 2.0 : 0.0)
                    }
                }
                
                if editor.showingInspectorView {
                    InspectorView(proxy: proxy)
                        .transition(.move(edge: .trailing))
                }
                
            }
            .ignoresSafeArea(.all, edges: .bottom)
            
            .sheet(isPresented: $editor.isShowingLessonSelector, content: {
                LessonSelectView()
            })
            
            .toolbar {
                
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button {
                        editor.isShowingLessonSelector = true
                    } label: {
                        Image(systemName: "xmark")
                    }
                    
                    if !editor.currentlySelectedLesson.slides.isEmpty {
                        Button {
                            withAnimation {
                                editor.showingLessonView.toggle()
                            }
                        } label: {
                            Image(systemName: "book.pages")
                        }
                    }
                }
                
                ToolbarItemGroup(placement: .secondaryAction) {
                    Text("\(editor.currentlySelectedLesson.lessonName)")
                        .fontWeight(.semibold)
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    
                    Button(role: .destructive) {
                        if let selectedComponent = editor.selectedComponent {
                            engine.remove(selectedComponent)
                        } else if let selectedContact = editor.lastTappedWireContact {
                            engine.remove(selectedContact)
                        }
                    } label: {
                        Image(systemName: "trash")
                    }
                    .disabled(editor.selectedComponent == nil && editor.lastTappedWireContact == nil)
                    
                    Button {
                        Task {
                            await engine.compute()
                        }
                    } label: {
                        Image(systemName: "play.fill")
                    }
                    
                    Button {
                        editor.toggleDrawingMode()
                    } label: {
                        Image(systemName: "pencil.and.outline")
                            .padding(5)
                            .foregroundStyle((editor.mode == .drawing) ? .white : .blue)
                            .background(RoundedRectangle(cornerRadius: 8, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/).foregroundStyle((editor.mode == .drawing) ? Color.blue : Color.clear))
                    }
                    
                    if editor.currentlySelectedLesson.freePlaceEnabled {
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
                    }
                }
            }
            .toolbarRole(.editor)
            .toolbarBackground(.visible, for: .navigationBar)

        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ReasonEngine())
        .environmentObject(EditorContext())
}
