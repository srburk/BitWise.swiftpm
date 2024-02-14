//
//  ReasonRenderingEngine.swift
//  
//
//  Created by Sam Burkhard on 2/13/24.
//

import Foundation
import SwiftUI

/// handles calculations for sizing components and manages their location in a virtual canvas
final class ReasonRenderingEngine {
    
    private var engine: ReasonEngine
        
    @Published var canvasScale: CGFloat = 1.0
    
    init(engine: ReasonEngine, canvasScale: CGFloat = 1.0) {
        self.engine = engine
        self.canvasScale = canvasScale
    }
    
}

extension ReasonRenderingEngine {
    
    public func checkForObjectAtPoint(_ point: CGPoint) -> BaseReasonComponent? {
        
        let localizedPoint = point.applying(.init(scaleX: 1/self.canvasScale, y: 1/self.canvasScale))
        if let tappedObject = self.engine.nodes.first(where: { object in
            let horizontal = (localizedPoint.x >= object.location.x) && (localizedPoint.x <= object.location.x + object.size.width)
            let vertical = (localizedPoint.y >= object.location.y) && (localizedPoint.y <= object.location.y + object.size.height)
            return horizontal && vertical
        }) {
            return tappedObject
        } else {
            return nil
        }
    }
    
    public func mapObject(_ component: BaseReasonComponent, with context: GraphicsContext) -> Path {
                        
        let transform = CGAffineTransform(translationX: component.location.x, y: component.location.y)
        let scaler = CGAffineTransform(scaleX: self.canvasScale, y: self.canvasScale)
        
        return (component.shape.path(in: CGRect(x: 0, y: 0, width: component.size.width, height: component.size.height)).applying(transform).applying(scaler))
    }
    
    public func dragObject(to value: DragGesture.Value) {
        
        for object in engine.nodes {
            object.location.x += value.translation.width / self.canvasScale
            object.location.y += value.translation.height / self.canvasScale
        }
    }
}
