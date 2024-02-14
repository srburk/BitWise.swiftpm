//
//  RendererView.swift
//
//
//  Created by Sam Burkhard on 2/7/24.
//

import Foundation
import SwiftUI

//class TestDisplayObject {
//    var shape = OR()
//    
//    var location: CGPoint
//    var size: CGSize // virtual canvas size
//    
//    init(shape: OR = OR(), location: CGPoint, size: CGSize) {
//        self.shape = shape
//        self.location = location
//        self.size = size
//    }
//}

final class RendererViewModel: ObservableObject {
    
    // some kind of mapping from intera coordinate space for components to the "real" coordinate space of the RendererView's Canvas. This way, coordinates stay in the same space and we can zoom in and out of the canvas
    
///     @Published var canvas: which is a description of coordinates and lines for the canvas view to draw. This is recalculated at some frequency?
    var canvasSize: CGSize?
        
    @Published var scale: CGFloat = 2.0
    /// Location of the top left corner of the canvas
    
//    @Published var testCanvas: [TestDisplayObject] = [
//        TestDisplayObject(location: .zero, size: CGSize(width: 100, height: 100)),
//        TestDisplayObject(location: .init(x: 150, y: 150), size: CGSize(width: 100, height: 100))
//    ]
    
//    public func checkForObjectAtPoint(_ point: CGPoint) -> BaseReasonComponent? {
//        
//        let localizedPoint = point.applying(.init(scaleX: 1/self.scale, y: 1/self.scale))
//        if let tappedObject = testCanvas.first(where: { object in
//            let horizontal = (localizedPoint.x >= object.location.x) && (localizedPoint.x <= object.location.x + object.size.width)
//            let vertical = (localizedPoint.y >= object.location.y) && (localizedPoint.y <= object.location.y + object.size.height)
//            return horizontal && vertical
//        }) {
//            return tappedObject
//        } else {
//            return nil
//        }
//    }
//    
//    public func mapObject(_ object: TestDisplayObject, to canvasSize: CGSize, with context: GraphicsContext) -> Path {
//        
//        self.canvasSize = canvasSize
//                
//        let transform = CGAffineTransform(translationX: object.location.x, y: object.location.y)
//        let scaler = CGAffineTransform(scaleX: self.scale, y: self.scale)
//        
//        return object.shape.path(in: CGRect(x: 0, y: 0, width: object.size.width, height: object.size.height)).applying(transform).applying(scaler)
//    }
//    
//    public func dragObject(to value: DragGesture.Value) {
//        
//        for object in testCanvas {
//            object.location.x += value.translation.width / self.scale
//            object.location.y += value.translation.height / self.scale
//        }
        
//        for object in testCanvas {
//            var newLocation = object.location
//            newLocation.x += value.translation.width / scale
//            guard newLocation.x > 0 && newLocation.x < self.canvasSize?.width ?? 5000 else { return }
//            newLocation.y += value.translation.height / scale
//            guard newLocation.y > 0 && newLocation.y < self.canvasSize?.height ?? 5000 else { return }
//        }
//    }
}

struct RendererView: View {
    
//    @ObservedObject var vm = RendererViewModel()
    @EnvironmentObject var engine: ReasonEngine
    
    @State private var position: CGPoint = .zero

    // drag operation changes based on editor context
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                engine.renderer?.dragObject(to: value)
                self.position.x += value.translation.width
                self.position.y += value.translation.height
            }
    }
    
    var body: some View {
        
        // composite view of pencil layer, text layer, and component layer, in that order
        VStack {
            ZStack {
                                
                // timeline view auto draws when changes occur
                TimelineView(.animation) { timeline in
                    Canvas { context, size in
                                                
                        for object in engine.nodes {
                            if let mapped = engine.renderer?.mapObject(object, with: context) {
                                context.fill(mapped, with: .color(.blue))
                            }
                        }
                    }
                    .drawingGroup() // high performance drawing
                }
                
                .onTapGesture(coordinateSpace: .local) { location in
                    if let tappedObject = engine.renderer?.checkForObjectAtPoint(location) {
                        print("Object tapped!")
                    }
                }
                
                Circle() // temporary handle for moving all components in view
                    .foregroundStyle(.green)
                    .frame(width: 100)
                    .gesture(drag)
                    .position(position)
                
            }
//            Slider(value: $engine.renderer?.scale, in: 0.25...3)
//                .padding(.bottom)
        }
    }
}

#Preview {
    RendererView()
}
