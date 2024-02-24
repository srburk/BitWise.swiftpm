//
//  LessonView.swift
//
//
//  Created by Sam Burkhard on 2/21/24.
//

import SwiftUI

struct LessonView: View {
    
    var lesson: Lesson
    var proxy: GeometryProxy
    
    @State var currentLesson = 0
    
    var body: some View {
        HStack {
            ZStack {
                
                Color(.sRGB, red: 0.97, green: 0.97, blue: 0.97)
                
                VStack(spacing: 15) {
                    HStack {
                        Text(lesson.slides[currentLesson].slideTitle)
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    
                    if lesson.slides[currentLesson].headlineShape != nil {
                        HStack(alignment: .center) {
                            Spacer()
                            lesson.slides[currentLesson].headlineShape?.path(in: .init(x: 0, y: 0, width: 100, height: 100))
                                .frame(width: 100, height: 100)
                                .foregroundStyle(.gray)
                            Spacer()
                        }
                        .frame(height: 150)
                        .background(Color(uiColor: .systemGray5), in: RoundedRectangle(cornerRadius: 10))
                    }
                    
                    HStack {
                        Text(lesson.slides[currentLesson].lessonPlan)
                        Spacer()
                    }
                    
                    Spacer()
                    
                    Button {
                        if currentLesson < lesson.slides.count - 1 {
                            currentLesson += 1
                        }
                    } label: {
                        HStack {
                            Text("Next Slide")
                            Image(systemName: "arrow.right.circle.fill")
                        }
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(width: proxy.size.width * 0.18, height: 50)
                        .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.blue))
                    }
                    .buttonStyle(.plain)
                }
                .padding(.top, 75)
                .padding()
            }
            .frame(width: proxy.size.width * 0.2)
            .border(Color(uiColor: .systemGray3), width: 0.5)
            .ignoresSafeArea(.all, edges: [.bottom, .top])
            
            Spacer()
        }
    }
}

#Preview {
    return NavigationStack {
        GeometryReader { proxy in
            LessonView(lesson: LessonService.lessons.first!, proxy: proxy)
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
