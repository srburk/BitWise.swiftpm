//
//  EditorContext.swift
//
//
//  Created by Sam Burkhard on 2/6/24.
//

import Foundation

// state machine for editing context
final class EditorContext: ObservableObject {
        
    @Published private(set) var mode: EditingMode = .none
    
    // this should be private(set) in the future. For prototyping I have it as public
    @Published public var lastTouchedComponent: BaseReasonComponent?
    
}

extension EditorContext {
    
    public func tappedComponent(_ component: BaseReasonComponent) {
        
        if mode == .wiring {
            
            if let sourceComponent = lastTouchedComponent, sourceComponent.id != component.id {
                _ = component.connect(to: sourceComponent)
            }
            self.mode = .none
            
        } else if mode == .none {
            self.mode = .wiring
        }
        
        self.lastTouchedComponent = component

    }
}
