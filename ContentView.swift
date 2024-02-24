import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var engine: ReasonEngine
    @EnvironmentObject var editor: EditorContext
        
    var body: some View {
        
        NavigationStack {
            
            GeometryReader { proxy in
                
                HStack {
                    if editor.showingLessonView && editor.currentlySelectedLesson != nil {
                        LessonView(lesson: LessonService.lessons.first!, proxy: proxy)
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
                    if editor.currentlySelectedLesson != nil {
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
                    if let lesson = editor.currentlySelectedLesson {
                        Text("\(lesson.lessonName)")
                            .fontWeight(.semibold)
                    }
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    
                    Button {
                        engine.orderNodes()
                        engine.compute()
                    } label: {
                        Image(systemName: "play.fill")
                    }
                    
                    if let lesson = editor.currentlySelectedLesson, lesson.freePlaceEnabled {
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
        .environmentObject(EditorContext())
}
