//
//  ViewController.swift
//  Wheather
//
//  Created by Timur Saidov on 04/07/2019.
//  Copyright © 2019 Timur Saidov. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    
    // MARK: Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    // MARK: ACtions
    
    @IBAction func reloadButtonTapped(_ sender: UIButton) {
        fetchWheather()
    }
    
    
    // MARK: Private Properties
    
    private var citiesWheather: [Wheather] = []
    private let locationManager = CLLocationManager()

    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchWheather()
        mapView.delegate = self
    }
    
    
    // MARK: Private
    
    private func fetchWheather() {
        updateView(isLoading: true)
        NetworkManager.shared.fetchWhether { [weak self] wheatherArray in
            guard let self = self else { return }
            self.citiesWheather = wheatherArray
            self.updateView(isLoading: false)
            self.setupPlacemark()
        }
    }
    
    private func updateView(isLoading: Bool) {
        mapView.isHidden = isLoading
        activityIndicator.isHidden = !isLoading
        isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
    private func setupPlacemark() {
        var annotations = [MKPointAnnotation]()
        for city in citiesWheather {
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(city.name) { (placemarks, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                guard let placemark = placemarks?.first else { return }
                guard let placemarkLocation = placemark.location else { return }
                let annotation = MKPointAnnotation()
                annotation.title = city.name
                annotation.subtitle = "\(city.description) \(city.temp)°C"
                annotation.coordinate = placemarkLocation.coordinate
                annotations.append(annotation)
                self.mapView.addAnnotation(annotation)
            }
        }
    }
}
