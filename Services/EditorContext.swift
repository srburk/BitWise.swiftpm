//
//  EditorContext.swift
//
//
//  Created by Sam Burkhard on 2/6/24.
//

import Foundation

final class EditorContext: ObservableObject {
        
    @Published private(set) var mode: EditingMode = .none
    
}

extension EditorContext {
    
    public func changeMode(to newMode: EditingMode) {
        
        self.mode = newMode
        
        switch newMode {
            case .none:
                Log.editor.log("EditorContext switched to \(newMode.rawValue)")
                break
            case .placement:
                Log.editor.log("EditorContext switched to \(newMode.rawValue)")
            case .wiring:
                Log.editor.log("EditorContext switched to \(newMode.rawValue)")
                
                // we need to store the last touched wire here
                
            case .drawing:
                Log.editor.log("EditorContext switched to \(newMode.rawValue)")
        }
    }
    
}
