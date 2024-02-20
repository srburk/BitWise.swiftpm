//
//  EditorContext.swift
//
//
//  Created by Sam Burkhard on 2/6/24.
//

import Foundation
import SwiftUI

enum EditingMode: String {
    case none, placement, wiringInput, wiringOutput, drawing // drawing is for apple pencil
}

// state machine for editing context
final class EditorContext: ObservableObject {
        
    @Published private(set) var mode: EditingMode = .none
    @Published private(set) var selectedComponent: BaseReasonComponent?
    
    // public variables
    @Published public var canvasScale: CGFloat = 1.0
    @Published public var showingInspectorView: Bool = true
    
    @ObservedObject private var engine: ReasonEngine
    
    init(engine: ReasonEngine, mode: EditingMode = .none, selectedComponent: BaseReasonComponent? = nil, canvasScale: CGFloat = 1.0) {
        self.engine = engine
        self.mode = mode
        self.selectedComponent = selectedComponent
        self.canvasScale = canvasScale
    }
}

extension EditorContext {
    
    public func tappedWireContact(_ component: BaseReasonComponent, wireContactIsInput: Bool) {
        
        if self.mode == .wiringInput || self.mode == .wiringOutput {
            
            // connect these 2 components
            if let sourceComponent = selectedComponent, sourceComponent.id != component.id {
                if wireContactIsInput && self.mode == .wiringOutput {
                    engine.connectComponent(component, to: sourceComponent)
                } else {
                    engine.connectComponent(sourceComponent, to: component)
                }
            }
            self.mode = .none
        } else {
            self.mode = wireContactIsInput ? .wiringInput : .wiringOutput
            self.selectedComponent = component
        }
        
    }
    
    public func tappedComponent(_ component: BaseReasonComponent) {
                
        // check for input to toggle based on tap
        if let input = component as? InputComponent {
            print("Toggled input")
            input.toggle()
        }
        
        if mode == .none {
            // bring up context stuff for changing attributes
        } else if mode == .placement && component.id == selectedComponent?.id {
            self.mode = .none
        }
        
        self.selectedComponent = component

    }
    
    public func draggingComponent(_ component: BaseReasonComponent) {
        self.selectedComponent = component
        self.mode = .placement
    }
}
