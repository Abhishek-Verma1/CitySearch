//
//  MapViewController.swift
//  CitySearch
//
//  Created by Abhishek Verma on 23/02/2022.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var viewModel: MapViewModel!
    var annotation: MKPointAnnotation?
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindUI()
        self.title = self.viewModel.title
        self.viewModel.viewDidLoad()
    }
    
    private func bindUI() {
        self.viewModel.showData = {  data in
            if let lat = data.coord?.lat,
               let lon = data.coord?.lon {
                
                let cityCoordinate = CLLocationCoordinate2D(latitude: lat,
                                                            longitude: lon)
                self.mapView.setCenter(cityCoordinate, animated: true)
                self.annotation = MKPointAnnotation()
                self.annotation?.title = data.name
                self.annotation?.coordinate = cityCoordinate
            }
        }
    }
    
}

extension MapViewController: MKMapViewDelegate {
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        if let annotation = annotation {
            mapView.addAnnotation(annotation)
            mapView.selectAnnotation(annotation, animated: true)
        }
    }
}
