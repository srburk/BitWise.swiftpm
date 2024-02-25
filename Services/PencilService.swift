//
//  PencilService.swift
//
//
//  Created by Sam Burkhard on 2/25/24.
//

import Foundation
import SwiftUI
import PencilKit

final class PencilService: ObservableObject {
    
    static let shared = PencilService()
    
    let toolPicker = PKToolPicker()
    var canvasView: PKCanvasView?

    func register(_ canvasView: PKCanvasView) {
        self.canvasView = canvasView
    }
    
    func showToolPicker() {
        if let canvas = canvasView {
            toolPicker.setVisible(true, forFirstResponder: canvas)
            toolPicker.addObserver(canvas)
            canvas.becomeFirstResponder()
        }
    }
    
    func hideToolPicker() {
        if let canvas = canvasView {
            toolPicker.setVisible(false, forFirstResponder: canvas)
            toolPicker.addObserver(canvas)
        }
    }
}
