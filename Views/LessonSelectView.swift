//
//  LessonSelectView.swift
//
//
//  Created by Sam Burkhard on 2/23/24.
//

import SwiftUI

struct LessonSelectView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var editor: EditorContext
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    self.dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .symbolRenderingMode(.hierarchical)
                        .foregroundColor(.gray)
                        .font(.title)
                }
                .padding()
            }
            
            Text("Lesson Select:")
                .font(.title)
            
            Divider()
                .padding()
            
            VStack(spacing: 25) {
                ForEach(LessonService.lessons, id: \.id) { lesson in
                    Button {
                        editor.currentlySelectedLesson = lesson
                        self.dismiss()
                        Log.general.log("Picked lesson: \(lesson.lessonName)")
                    } label: {
                        HStack {
                            Text("\(lesson.lessonName)")
                                .font(.title3)
                            Spacer()
                            Image(systemName: "arrow.right")
                        }
                        .padding()
                        .background(Color(uiColor: .systemGray5), in: RoundedRectangle(cornerRadius: 10))
                    }
                    .buttonStyle(.plain)
                }
            }
            .frame(width: 500)
            
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        Text("stuff back here")
        
        .sheet(isPresented: /*@START_MENU_TOKEN@*/.constant(true)/*@END_MENU_TOKEN@*/, content: {
            LessonSelectView()
        })
    }
}
