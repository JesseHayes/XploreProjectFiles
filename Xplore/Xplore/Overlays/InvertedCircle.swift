//
//  InvertedCircle.swift
//  Xplore
//
//  Created by JESSE HAYES on 2019-12-28.
//  Copyright © 2019 JESSE HAYES. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class MKInvertedCircle : NSObject, MKOverlay {

    var coordinate: CLLocationCoordinate2D
    
    var boundingMapRect: MKMapRect {
        return MKMapRect(x: 180, y: 360, width: 180, height: 360)
    }
    
    init(center coord: CLLocationCoordinate2D) {
        self.coordinate = coord
    }
}
