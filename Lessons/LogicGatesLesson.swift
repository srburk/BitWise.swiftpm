//
//  LogicGatesLesson.swift
//
//
//  Created by Sam Burkhard on 2/23/24.
//

import SwiftUI

var LogicGatesLesson: Lesson {
    
    var lessonName: String = "Logic Gates"
    
    var freePlaceEnabled: Bool = false
    
    var slides: [LessonSlide] = [
    
        LessonSlide(slideTitle: "The NOT Gate", lessonPlan: """
        NOT gates *invert* their input. For example, when given an output of **on**, the NOT gate outputs **off**
        """, headlineShape: {
            return NOTShape()
        }(), engineLoadingCommand: { engine in
            let notGate = NOTGate(position: .init(x: 500, y: 300))
            let input = InputComponent(position: .init(x: 200, y: 300))
            let output = OutputComponent(position: .init(x: 800, y: 300))
            
            engine.connectComponent(input, component2: notGate, connector1: input.outputConnections.first!, connector2: notGate.inputConnections.first!)
            
            engine.connectComponent(output, component2: notGate, connector1: output.inputConnections.first!, connector2: notGate.outputConnections.first!)
            
            engine.add([notGate, input, output])
            
        }),
        
        LessonSlide(slideTitle: "The OR Gate", lessonPlan: """
        OR gates blah blah blah asdlfkjsadfajsdflkj
        """, headlineShape: {
            return ORShape()
        }(), engineLoadingCommand: { engine in
            let orGate = ORGate(position: .init(x: 500, y: 300))
            let input1 = InputComponent(position: .init(x: 200, y: 150))
            let input2 = InputComponent(position: .init(x: 200, y: 450))
            let output = OutputComponent(position: .init(x: 800, y: 300))
            
            engine.connectComponent(input1, component2: orGate, connector1: input1.outputConnections.first!, connector2: orGate.inputConnections[0])
            
            engine.connectComponent(input2, component2: orGate, connector1: input2.outputConnections.first!, connector2: orGate.inputConnections[1])
            
            engine.connectComponent(output, component2: orGate, connector1: output.inputConnections.first!, connector2: orGate.outputConnections.first!)
            
            engine.add([orGate, input1, input2, output])
        })
    
    ]
    
    return Lesson(lessonName: lessonName, slides: slides, freePlaceEnabled: freePlaceEnabled)
}

#Preview {
    return NavigationStack {
        GeometryReader { proxy in
            LessonView(lesson: LogicGatesLesson, proxy: proxy)
                .environmentObject(ReasonEngine())
        }
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text(LogicGatesLesson.lessonName)
                    .font(.headline)
            }
        }
    }
}
