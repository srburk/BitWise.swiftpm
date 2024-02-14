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
    
    // this should be private(set) in the future. For prototyping I have it as public
    @Published public var selectedComponent: BaseReasonComponent?
    
    // editor context will need to communicate with rendering engine for reasonkit
    
}

extension EditorContext {
    
    public func tappedComponent(_ component: BaseReasonComponent) {
        
        // check for input to toggle based on tap
        if let input = component as? InputComponent {
            input.toggle()
        }
        
        if mode == .wiring {
            
            if let sourceComponent = selectedComponent, sourceComponent.id != component.id {
                _ = component.connect(to: sourceComponent)
            }
            self.mode = .none
            
        } else if mode == .none {
            self.mode = .placement
        }
        
        self.selectedComponent = component

    }
}
