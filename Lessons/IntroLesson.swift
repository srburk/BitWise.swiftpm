//
//  FreePlayLesson.swift
//
//
//  Created by Sam Burkhard on 2/24/24.
//

import Foundation
import SwiftUI


var IntroLesson: Lesson {

    let lessonName = "Introduction to BitWise"
    
    let introSlide = LessonSlide(slideTitle: "Welcome to BitWise!", lessonPlan: """
    This is BitWise-a digital circuit simulator. BitWise loads lessons and displays them here in the lesson sidebar. Toggle the lesson sidebar with the page icon above. Select from other lessons using the top left toolbar item.
    """, headlineShape: RoundedRectangle(cornerRadius: 10),engineLoadingCommand: { _ in })
    
    let secondSlide = LessonSlide(slideTitle: "Using the Simulator", lessonPlan: """
    Open the tools popover on the right to place components. Press the play button to compute values in the background. Use the pencil icon to annotate with your Apple Pencil.
    """) { _ in
    }
    
    let thirdSlide = LessonSlide(slideTitle: "Interacting with Components", lessonPlan: """
    Select circular contact points on logic components to connect them. Selected components can be removed using the trash icon in the top right of the toolbar.
    """) { _ in
    
    }
    
    return Lesson(lessonName: lessonName, slides: [introSlide, secondSlide], freePlaceEnabled: true)
}

