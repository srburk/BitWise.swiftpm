//
//  File.swift
//  
//
//  Created by Sam Burkhard on 2/23/24.
//

import Foundation
import SwiftUI

protocol Lesson {
    var id: UUID { get }
    var lessonName: String { get }
    var slides: [LessonSlide] { get }
}

struct LessonSlide {
    var slideTitle: String
    var lessonPlan: LocalizedStringKey
    var headlineShape: (any Shape)?
//    var slideCompleteCondition: () -> Bool
}
