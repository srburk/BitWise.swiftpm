//
//  EditorContext.swift
//
//
//  Created by Sam Burkhard on 2/6/24.
//

import Foundation
import SwiftUI

enum EditingMode: String {
    case none, placement, wiring, drawing // drawing is for apple pencil
}

// state machine for editing context
final class EditorContext: ObservableObject {
        
    @Published private(set) var mode: EditingMode = .none
    @Published private(set) var selectedComponent: BaseReasonComponent?
    @Published private(set) var lastTappedWireContact: ComponentConnector?
    
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
    
    public func isValidWireContact(contact: ComponentConnector) -> Bool {
        
        if let lastContact = lastTappedWireContact {
            if lastContact.type == .input {
                return contact.type == .output && contact.connection == nil
            } else {
                return contact.type == .input && contact.connection == nil
            }
        } else {
            return false
        }
    }
    
    public func tappedWireContact(_ component: BaseReasonComponent, contact: ComponentConnector) {
        
        if self.mode == .wiring {
            
            guard self.isValidWireContact(contact: contact) else { Log.editor.error("Contact point not valid") ; return }
            
            // connect these 2 components
            if let sourceComponent = selectedComponent, let sourceContact = self.lastTappedWireContact, sourceComponent.id != component.id {
//                if wireContactIsInput && self.mode == .wiringOutput {
//                    engine.connectComponent(component, to: sourceComponent)
//                } else {
//                    engine.connectComponent(sourceComponent, to: component)
//                }
                
                engine.connectComponent(component, component2: sourceComponent, connector1: contact, connector2: sourceContact)
                
            }
            self.mode = .none
        } else {
            self.mode = .wiring
            self.lastTappedWireContact = contact
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
