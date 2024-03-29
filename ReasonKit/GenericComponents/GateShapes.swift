//
//  GateShapes.swift
//
//
//  Created by Sam Burkhard on 2/19/24.
//

import Foundation
import SwiftUI

struct ANDShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0, y: 0.03788*height))
        path.addCurve(to: CGPoint(x: 0.03521*width, y: 0), control1: CGPoint(x: 0, y: 0.01696*height), control2: CGPoint(x: 0.01576*width, y: 0))
        path.addLine(to: CGPoint(x: 0.54225*width, y: 0))
        path.addCurve(to: CGPoint(x: width, y: 0.49242*height), control1: CGPoint(x: 0.79506*width, y: 0), control2: CGPoint(x: width, y: 0.22047*height))
        path.addLine(to: CGPoint(x: width, y: 0.50758*height))
        path.addCurve(to: CGPoint(x: 0.54225*width, y: height), control1: CGPoint(x: width, y: 0.77954*height), control2: CGPoint(x: 0.79506*width, y: height))
        path.addLine(to: CGPoint(x: 0.03521*width, y: height))
        path.addCurve(to: CGPoint(x: 0, y: 0.96212*height), control1: CGPoint(x: 0.01576*width, y: height), control2: CGPoint(x: 0, y: 0.98304*height))
        path.addLine(to: CGPoint(x: 0, y: 0.4697*height))
        path.addLine(to: CGPoint(x: 0, y: 0.03788*height))
        path.closeSubpath()
        return path
    }
}

struct NOTShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.73239*width, y: 0.5*height))
        path.addLine(to: CGPoint(x: 0.03245*width, y: 0.99278*height))
        path.addCurve(to: CGPoint(x: 0, y: 0.97299*height), control1: CGPoint(x: 0.01838*width, y: 1.00269*height), control2: CGPoint(x: 0, y: 0.99148*height))
        path.addLine(to: CGPoint(x: 0, y: 0.02701*height))
        path.addCurve(to: CGPoint(x: 0.03245*width, y: 0.00722*height), control1: CGPoint(x: 0, y: 0.00853*height), control2: CGPoint(x: 0.01838*width, y: -0.00268*height))
        path.addLine(to: CGPoint(x: 0.73239*width, y: 0.5*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: width, y: 0.5*height))
        path.addCurve(to: CGPoint(x: 0.77465*width, y: 0.75*height), control1: CGPoint(x: width, y: 0.63807*height), control2: CGPoint(x: 0.89911*width, y: 0.75*height))
        path.addCurve(to: CGPoint(x: 0.5493*width, y: 0.5*height), control1: CGPoint(x: 0.65019*width, y: 0.75*height), control2: CGPoint(x: 0.5493*width, y: 0.63807*height))
        path.addCurve(to: CGPoint(x: 0.77465*width, y: 0.25*height), control1: CGPoint(x: 0.5493*width, y: 0.36193*height), control2: CGPoint(x: 0.65019*width, y: 0.25*height))
        path.addCurve(to: CGPoint(x: width, y: 0.5*height), control1: CGPoint(x: 0.89911*width, y: 0.25*height), control2: CGPoint(x: width, y: 0.36193*height))
        path.closeSubpath()
        return path
    }
}

struct ORShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.00826*width, y: 0.05457*height))
        path.addCurve(to: CGPoint(x: 0.00429*width, y: 0.01975*height), control1: CGPoint(x: 0.00284*width, y: 0.04361*height), control2: CGPoint(x: -0.00124*width, y: 0.03064*height))
        path.addCurve(to: CGPoint(x: 0.03521*width, y: 0), control1: CGPoint(x: 0.01026*width, y: 0.00798*height), control2: CGPoint(x: 0.02187*width, y: 0))
        path.addLine(to: CGPoint(x: 0.54225*width, y: 0))
        path.addCurve(to: CGPoint(x: width, y: 0.49242*height), control1: CGPoint(x: 0.79506*width, y: 0), control2: CGPoint(x: width, y: 0.22047*height))
        path.addLine(to: CGPoint(x: width, y: 0.50758*height))
        path.addCurve(to: CGPoint(x: 0.54225*width, y: height), control1: CGPoint(x: width, y: 0.77954*height), control2: CGPoint(x: 0.79506*width, y: height))
        path.addLine(to: CGPoint(x: 0.03521*width, y: height))
        path.addCurve(to: CGPoint(x: 0.00454*width, y: 0.98073*height), control1: CGPoint(x: 0.02205*width, y: height), control2: CGPoint(x: 0.01058*width, y: 0.99223*height))
        path.addCurve(to: CGPoint(x: 0.00872*width, y: 0.94507*height), control1: CGPoint(x: -0.0013*width, y: 0.96963*height), control2: CGPoint(x: 0.003*width, y: 0.95626*height))
        path.addLine(to: CGPoint(x: 0.0965*width, y: 0.77337*height))
        path.addCurve(to: CGPoint(x: 0.09991*width, y: 0.2398*height), control1: CGPoint(x: 0.18129*width, y: 0.60753*height), control2: CGPoint(x: 0.18257*width, y: 0.40687*height))
        path.addLine(to: CGPoint(x: 0.00826*width, y: 0.05457*height))
        path.closeSubpath()
        return path
    }
}

struct XORShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.12403*width, y: 0.05342*height))
        path.addCurve(to: CGPoint(x: 0.12044*width, y: 0.02113*height), control1: CGPoint(x: 0.11956*width, y: 0.04319*height), control2: CGPoint(x: 0.11624*width, y: 0.0315*height))
        path.addCurve(to: CGPoint(x: 0.14832*width, y: 0), control1: CGPoint(x: 0.12551*width, y: 0.00861*height), control2: CGPoint(x: 0.13609*width, y: 0))
        path.addLine(to: CGPoint(x: 0.59592*width, y: 0))
        path.addCurve(to: CGPoint(x: width, y: 0.49242*height), control1: CGPoint(x: 0.81909*width, y: 0), control2: CGPoint(x: width, y: 0.22047*height))
        path.addLine(to: CGPoint(x: width, y: 0.50758*height))
        path.addCurve(to: CGPoint(x: 0.59592*width, y: height), control1: CGPoint(x: width, y: 0.77954*height), control2: CGPoint(x: 0.81909*width, y: height))
        path.addLine(to: CGPoint(x: 0.14832*width, y: height))
        path.addCurve(to: CGPoint(x: 0.12063*width, y: 0.97934*height), control1: CGPoint(x: 0.13624*width, y: height), control2: CGPoint(x: 0.12577*width, y: 0.99161*height))
        path.addCurve(to: CGPoint(x: 0.12442*width, y: 0.94622*height), control1: CGPoint(x: 0.11618*width, y: 0.96873*height), control2: CGPoint(x: 0.1197*width, y: 0.95668*height))
        path.addLine(to: CGPoint(x: 0.21182*width, y: 0.75256*height))
        path.addCurve(to: CGPoint(x: 0.21471*width, y: 0.26104*height), control1: CGPoint(x: 0.2816*width, y: 0.59794*height), control2: CGPoint(x: 0.28267*width, y: 0.41664*height))
        path.addLine(to: CGPoint(x: 0.12403*width, y: 0.05342*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.02069*width, y: 0.96212*height))
        path.addLine(to: CGPoint(x: 0.11527*width, y: 0.75256*height))
        path.addCurve(to: CGPoint(x: 0.11816*width, y: 0.26104*height), control1: CGPoint(x: 0.18505*width, y: 0.59794*height), control2: CGPoint(x: 0.18612*width, y: 0.41664*height))
        path.addLine(to: CGPoint(x: 0.02069*width, y: 0.03788*height))
        return path
    }
}
