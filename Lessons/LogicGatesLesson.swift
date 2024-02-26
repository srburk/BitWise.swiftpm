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
            
            Task {
                await engine.connectComponent(input, component2: notGate, connector1: input.outputConnections.first!, connector2: notGate.inputConnections.first!)
                
                await engine.connectComponent(output, component2: notGate, connector1: output.inputConnections.first!, connector2: notGate.outputConnections.first!)
                
                await engine.add([notGate, input, output])
            }
        }),
        
        LessonSlide(slideTitle: "The OR Gate", lessonPlan: """
        OR gates output true if one or both of their inputs are true.
        """, headlineShape: {
            return ORShape()
        }(), engineLoadingCommand: { engine in
            let orGate = ORGate(position: .init(x: 500, y: 300))
            let input1 = InputComponent(position: .init(x: 200, y: 150))
            let input2 = InputComponent(position: .init(x: 200, y: 450))
            let output = OutputComponent(position: .init(x: 800, y: 300))
            
            Task {
                await engine.connectComponent(input1, component2: orGate, connector1: input1.outputConnections.first!, connector2: orGate.inputConnections[0])
                
                await engine.connectComponent(input2, component2: orGate, connector1: input2.outputConnections.first!, connector2: orGate.inputConnections[1])
                
                await engine.connectComponent(output, component2: orGate, connector1: output.inputConnections.first!, connector2: orGate.outputConnections.first!)
                
                await engine.add([orGate, input1, input2, output])
            }
            
        }),
        
        LessonSlide(slideTitle: "The AND Gate", lessonPlan: """
        AND gates output true *only if both* of their inputs are true.
        """, headlineShape: {
            return ANDShape()
        }(), engineLoadingCommand: { engine in
            let andGate = ANDGate(position: .init(x: 500, y: 300))
            let input1 = InputComponent(position: .init(x: 200, y: 150))
            let input2 = InputComponent(position: .init(x: 200, y: 450))
            let output = OutputComponent(position: .init(x: 800, y: 300))
            
            Task {
                await engine.connectComponent(input1, component2: andGate, connector1: input1.outputConnections.first!, connector2: andGate.inputConnections[0])
                
                await engine.connectComponent(input2, component2: andGate, connector1: input2.outputConnections.first!, connector2: andGate.inputConnections[1])
                
                await engine.connectComponent(output, component2: andGate, connector1: output.inputConnections.first!, connector2: andGate.outputConnections.first!)
                
                await engine.add([andGate, input1, input2, output])
            }
            
        })
    
    ]
    
    return Lesson(lessonName: lessonName, slides: slides, freePlaceEnabled: freePlaceEnabled)
}

#Preview {
    return NavigationStack {
        GeometryReader { proxy in
            LessonView(proxy: proxy)
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
