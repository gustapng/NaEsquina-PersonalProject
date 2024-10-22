//
//  MapView.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 22/10/24.
//

import UIKit
import MapKit

class MapView: UIView {

    // MARK: - UI Components

    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.pointOfInterestFilter = .excludingAll
//        mapView.overrideUserInterfaceStyle = .light
        return mapView
    }()
    
    // MARK: - Functions
    
    private func setInitialLocation(location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    // MARK: - Lifecycle

    init() {
        super.init(frame: .zero)
        setup()
        let initialLocation = CLLocation(latitude: -23.55052, longitude: -46.63331)
        let annotation = MKPointAnnotation()
        // ADICIONA O PIN DA COORDENADA
        annotation.coordinate = CLLocationCoordinate2D(latitude: -23.55052, longitude: -46.63331)
        mapView.addAnnotation(annotation)
        setInitialLocation(location: initialLocation)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MapView: SetupView {
    func setup() {
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        addSubview(mapView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
