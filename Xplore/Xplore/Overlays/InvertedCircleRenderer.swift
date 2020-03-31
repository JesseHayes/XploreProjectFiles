//
//  InvertedCircleRenderer.swift
//  Xplore
//
//  Created by JESSE HAYES on 2019-12-28.
//  Copyright © 2019 JESSE HAYES. All rights reserved.
//
import Foundation
import UIKit
import MapKit

class MKInvertedCircleOverlayRenderer: MKOverlayRenderer {

var fillColor: UIColor = UIColor.red
var strokeColor: UIColor = UIColor.blue
var lineWidth: CGFloat = 3
var circle: MKCircle
    
init(circle: MKCircle) {
    self.circle = circle
    super.init(overlay: circle)
}

    override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext) {
        let path = UIBezierPath(rect: rect(for: MKMapRect.world))
        
   
    
    let excludePath: UIBezierPath = UIBezierPath(roundedRect: CGRect(x: circle.coordinate.latitude,
                                                                     y: circle.coordinate.longitude,
                                                                     width: circle.boundingMapRect.size.width,
                                                                     height: circle.boundingMapRect.size.height),
                                                 cornerRadius: CGFloat(circle.boundingMapRect.size.width))
    
    context.setFillColor(fillColor.cgColor)

    path.append(excludePath)
    context.addPath(path.cgPath)
    context.fillPath(using: .evenOdd)
    
    

    context.addPath(excludePath.cgPath)
    context.setLineWidth(9 / zoomScale)
    context.setStrokeColor(strokeColor.cgColor)
    context.strokePath()

    
}
}
