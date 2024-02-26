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
        }),
        
        LessonSlide(slideTitle: "The XOR Gate", lessonPlan: """
        XOR gates output true *only if* their inputs **are not** the same.
        """, headlineShape: {
            return XORShape()
        }(), engineLoadingCommand: { engine in
            let XORGate = XORGate(position: .init(x: 500, y: 300))
            let input1 = InputComponent(position: .init(x: 200, y: 150))
            let input2 = InputComponent(position: .init(x: 200, y: 450))
            let output = OutputComponent(position: .init(x: 800, y: 300))
            
            Task {
                await engine.connectComponent(input1, component2: XORGate, connector1: input1.outputConnections.first!, connector2: XORGate.inputConnections[0])
                
                await engine.connectComponent(input2, component2: XORGate, connector1: input2.outputConnections.first!, connector2: XORGate.inputConnections[1])
                
                await engine.connectComponent(output, component2: XORGate, connector1: output.inputConnections.first!, connector2: XORGate.outputConnections.first!)
                
                await engine.add([XORGate, input1, input2, output])
            }
        }),
        
        LessonSlide(slideTitle: "Bringing It All Together", lessonPlan: """
        Logic gates are exceptionally simple machines. When combined in creative ways, they allow for complex operations. Here is a full adder, which takes 2 1-bit inputs and computes their sum.
        """, engineLoadingCommand: { engine in
            let XORGate1 = XORGate(position: .init(x: 300, y: 150))
            let XORGate2 = XORGate(position: .init(x: 500, y: 150))
            
            let andGate1 = ANDGate(position: .init(x: 300, y: 350))
            let andGate2 = ANDGate(position: .init(x: 500, y: 450))
            
            let orGate = ORGate(position: .init(x: 650, y: 350))
            
            let input1 = InputComponent(position: .init(x: 100, y: 150))
            let input2 = InputComponent(position: .init(x: 100, y: 350))
            
            let carryIn = InputComponent(position: .init(x: 200, y: 600))
            
            let sum = OutputComponent(position: .init(x: 850, y: 150))
            let carryOut = OutputComponent(position: .init(x: 850, y: 450))
            
            Task {
                
                await engine.connectComponent(input1, component2: XORGate1, connector1: input1.outputConnections[0], connector2: XORGate1.inputConnections.first!)
                
                await engine.connectComponent(input1, component2: andGate1, connector1: input1.outputConnections[0], connector2: andGate1.inputConnections[1])
                
                await engine.connectComponent(input2, component2: XORGate1, connector1: input2.outputConnections[0], connector2: XORGate1.inputConnections[1])
                
                await engine.connectComponent(input2, component2: andGate1, connector1: input2.outputConnections[0], connector2: andGate1.inputConnections[0])
                
                await engine.connectComponent(XORGate1, component2: XORGate2, connector1: XORGate1.outputConnections.first!, connector2: XORGate2.inputConnections.first!)
                
                await engine.connectComponent(andGate1, component2: andGate2, connector1: andGate1.outputConnections.first!, connector2: andGate2.inputConnections.first!)
                
                await engine.connectComponent(carryIn, component2: andGate2, connector1: carryIn.outputConnections.first!, connector2: andGate2.inputConnections[1])
                
                await engine.connectComponent(carryIn, component2: XORGate2, connector1: carryIn.outputConnections.first!, connector2: XORGate2.inputConnections[1])
                
                await engine.connectComponent(andGate1, component2: orGate, connector1: andGate1.outputConnections.first!, connector2: orGate.inputConnections.first!)
                
                await engine.connectComponent(andGate2, component2: orGate, connector1: andGate2.outputConnections.first!, connector2: orGate.inputConnections[1])
                
                await engine.connectComponent(XORGate2, component2: sum, connector1: XORGate2.outputConnections.first!, connector2: sum.inputConnections[0])
                
                await engine.connectComponent(orGate, component2: carryOut, connector1: orGate.outputConnections.first!, connector2: carryOut.inputConnections[0])
                
                await engine.add([XORGate1, XORGate2, andGate1, andGate2, input1, input2, carryIn, sum, carryOut, orGate])
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
