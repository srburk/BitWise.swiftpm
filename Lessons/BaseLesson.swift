//
//  File.swift
//  
//
//  Created by Sam Burkhard on 2/23/24.
//

import Foundation
import SwiftUI

class Lesson: Equatable {
    static func == (lhs: Lesson, rhs: Lesson) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: UUID = UUID()
    var lessonName: String
    var slides: [LessonSlide]
    var freePlaceEnabled: Bool
    
    init(lessonName: String, slides: [LessonSlide], freePlaceEnabled: Bool) {
        self.lessonName = lessonName
        self.slides = slides
        self.freePlaceEnabled = freePlaceEnabled
    }
}

struct LessonSlide {
    var slideTitle: String
    var lessonPlan: LocalizedStringKey
    var headlineShape: (any Shape)?
    
    var engineLoadingCommand: (ReasonEngine) -> Void
//    var slideCompleteCondition: () -> Bool
}
