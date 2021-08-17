//
//  Capital.swift
//  Project16-Maps
//
//  Created by Felipe Gil on 2021-08-17.
//

import MapKit
import UIKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    var webSite: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String, webSite: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
        self.webSite = webSite
    }
    
}
