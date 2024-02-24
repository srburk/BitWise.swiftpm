//
//  LogicGatesLesson.swift
//
//
//  Created by Sam Burkhard on 2/23/24.
//

import SwiftUI

struct LogicGatesLesson: Lesson {
    var id: UUID = UUID()
    var lessonName: String = "Logic Gates"
    var slides: [LessonSlide] = [
    
        .init(slideTitle: "The NOT Gate", lessonPlan: """
        Not gates blah blah blah asdlfkjsadfajsdflkj
        """, headlineShape: {
            return NOTShape()
        }())
    
    ]
}

#Preview {
    return NavigationStack {
        GeometryReader { proxy in
            LessonView(lesson: LogicGatesLesson(), proxy: proxy)
        }
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text(LogicGatesLesson().lessonName)
                    .font(.headline)
            }
        }
    }
}
