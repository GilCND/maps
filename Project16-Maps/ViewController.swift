//
//  ViewController.swift
//  Project16-Maps
//
//  Created by Felipe Gil on 2021-08-17.
//

import UIKit
import MapKit

class ViewController: UIViewController{
    @IBOutlet weak var mapView: MKMapView!
    enum mapType {
        case satellite, standard, hybrid
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let london = Capital(title: "london", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics", webSite: "https://en.wikipedia.org/wiki/London")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.", webSite: "https://en.wikipedia.org/wiki/Oslo")
        let canoas = Capital(title: "Porto Alegre", coordinate: CLLocationCoordinate2D(latitude: -30.0368, longitude: -51.2090), info: "Gremio, the best team ever created", webSite: "https://en.wikipedia.org/wiki/Porto_Alegre")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light", webSite: "https://en.wikipedia.org/wiki/Paris")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.", webSite: "https://en.wikipedia.org/wiki/Rome")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself", webSite: "https://en.wikipedia.org/wiki/Washington,_D.C.")
        
        mapView.addAnnotations([london, oslo, canoas, paris, rome, washington])
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(selectMapType))
    }
    
    @objc private func selectMapType() {
        let changeMapTypeAlertController = UIAlertController(title: nil, message: "Please select a preferred map style", preferredStyle: .alert)
        changeMapTypeAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        changeMapTypeAlertController.addAction(UIAlertAction(title: "Satelite", style: .default, handler: { [weak self, weak changeMapTypeAlertController] _ in
                  guard let self = self else { return }
            self.applyMapType(mapType: .satellite)
            changeMapTypeAlertController?.dismiss(animated: true)
        }))
        changeMapTypeAlertController.addAction(UIAlertAction(title: "Standard", style: .default, handler: { [weak self, weak changeMapTypeAlertController] _ in
                  guard let self = self else { return }
            self.applyMapType(mapType: .standard)
            changeMapTypeAlertController?.dismiss(animated: true)
        }))
        changeMapTypeAlertController.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: { [weak self, weak changeMapTypeAlertController] _ in
                  guard let self = self else { return }
            self.applyMapType(mapType: .hybrid)
            changeMapTypeAlertController?.dismiss(animated: true)
        }))
        present(changeMapTypeAlertController, animated: true)
    }
    
    private func applyMapType(mapType: mapType){
        switch mapType {
        case .hybrid:
            mapView.mapType = .hybrid
        case .satellite:
            mapView.mapType = .satellite
        case .standard:
            mapView.mapType = .standard
        }
    }
}

extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.pinTintColor = .black
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        
        let placeName = capital.title
        let placeInfo = capital.info
        let webSite = capital.webSite
    
        let moreInformationAlertController = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        moreInformationAlertController.addAction(UIAlertAction(title: "OK", style: .default))
        moreInformationAlertController.addAction(UIAlertAction(title: "Read More", style: .default, handler: { [weak self] _ in
            guard let self = self, let moreInformationViewController = self.storyboard?.instantiateViewController(withIdentifier: "more") as? MoreInformationViewController else { return }
            
            moreInformationViewController.urlString = webSite
            
            self.navigationController?.pushViewController(moreInformationViewController, animated: true)
        }))
        present(moreInformationAlertController, animated: true)
    }
    
}
