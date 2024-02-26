//
//  LessonView.swift
//
//
//  Created by Sam Burkhard on 2/21/24.
//

import SwiftUI

struct LessonView: View {
    
    var proxy: GeometryProxy
    
    @EnvironmentObject var editor: EditorContext
    @EnvironmentObject var engine: ReasonEngine
        
    private var nextButton: some View {
        Button {
            if editor.currentSlide < editor.currentlySelectedLesson.slides.count - 1 {
                editor.currentSlide += 1
            }
        } label: {
            HStack {
                Spacer()
                Text("Next")
                Image(systemName: "arrow.right.circle.fill")
                Spacer()
            }
            .font(.headline)
            .foregroundStyle(.white)
            .frame(height: 50)
            .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.blue))
        }
        .buttonStyle(.plain)
    }
    
    private var backButton: some View {
        Button {
            if editor.currentSlide > 0 {
                editor.currentSlide -= 1
            }
        } label: {
            HStack {
                Spacer()
                Image(systemName: "arrow.left.circle.fill")
                Text("Back")
                Spacer()
            }
            .font(.headline)
            .foregroundStyle(.white)
            .frame(height: 50)
            .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.gray))
        }
        .buttonStyle(.plain)
    }
    
    private var finishButton: some View {
        Button {
            // finish
        } label: {
            HStack {
                Spacer()
                Text("Finish")
                Image(systemName: "checkmark.circle.fill")
                Spacer()
            }
            .font(.headline)
            .foregroundStyle(.white)
            .frame(height: 50)
            .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.green))
        }
    }
    
    private func reloadComponents() {
        if !editor.currentlySelectedLesson.slides.isEmpty {
            engine.removeAll()
            editor.currentlySelectedLesson.slides[editor.currentSlide].engineLoadingCommand(engine)
        }
    }
    
    var body: some View {
        HStack {
            ZStack {
                
                Color(.sRGB, red: 0.97, green: 0.97, blue: 0.97)
                
                if !editor.currentlySelectedLesson.slides.isEmpty {
                    VStack(spacing: 15) {
                        HStack {
                            Text(editor.currentlySelectedLesson.slides[editor.currentSlide].slideTitle)
                                .font(.title3)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        
                        if editor.currentlySelectedLesson.slides[editor.currentSlide].headlineShape != nil {
                            HStack(alignment: .center) {
                                Spacer()
                                editor.currentlySelectedLesson.slides[editor.currentSlide].headlineShape?.path(in: .init(x: 0, y: 0, width: 100, height: 100))
                                    .frame(width: 100, height: 100)
                                    .foregroundStyle(.gray)
                                Spacer()
                            }
                            .frame(height: 150)
                            .background(Color(uiColor: .systemGray5), in: RoundedRectangle(cornerRadius: 10))
                        }
                        
                        HStack {
                            Text(editor.currentlySelectedLesson.slides[editor.currentSlide].lessonPlan)
                            Spacer()
                        }
                        
                        Spacer()
                        
                        if (editor.currentSlide == 0 && editor.currentlySelectedLesson.slides.count > 1) {
                            nextButton
                        } else if editor.currentSlide == editor.currentlySelectedLesson.slides.count - 1 {
                            backButton
                        } else {
                            HStack(spacing: 10) {
                                backButton
                                nextButton
                            }
                        }
                    }
                    .padding(.top, 75)
                    .padding()
                    
                    .onChange(of: editor.currentlySelectedLesson) { _ in
                        reloadComponents()
                    }
                    
                    .onChange(of: editor.currentSlide) { _ in
                        reloadComponents()
                    }
                }
                
            }
            .frame(width: proxy.size.width * 0.2)
            .border(Color(uiColor: .systemGray3), width: 0.5)
            .ignoresSafeArea(.all, edges: [.bottom, .top])
            .onAppear {
                reloadComponents()
            }
        }
    }
}

#Preview {
    return NavigationStack {
        GeometryReader { proxy in
            LessonView(proxy: proxy)
                .environmentObject(EditorContext())
        }
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text("Hello")
            }
            ToolbarItem(placement: .topBarTrailing) {
                Text("Hello")
            }
        }
    }
}
