//
//  SwiftUIView.swift
//  
//
//  Created by Sam Burkhard on 2/25/24.
//

import SwiftUI
import PencilKit

struct PencilView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let canvasView = PKCanvasView()
        
        canvasView.drawingPolicy = .pencilOnly
        canvasView.backgroundColor = .clear
        canvasView.tool = PKInkingTool(.pen, color: .black, width: 10)
        
        PencilService.shared.register(canvasView)
        
        return canvasView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
