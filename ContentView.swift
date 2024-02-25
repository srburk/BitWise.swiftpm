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

                    RendererView()
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
                    
                    Button {
                        engine.orderNodes()
                        engine.compute()
                    } label: {
                        Image(systemName: "play.fill")
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
