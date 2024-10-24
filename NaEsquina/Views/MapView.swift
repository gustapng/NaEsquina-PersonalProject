//
//  MapView.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 22/10/24.
//

import UIKit
import MapKit

protocol MapViewDelegate: AnyObject {
    func didTapOnPin(annotationTitle: String?)
}

class MapView: UIView, MKMapViewDelegate {
    
    // MARK: - Variables
    
    weak var delegate: MapViewDelegate?

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
    
    // MARK: - MKMapViewDelegate

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKPointAnnotation {
            let identifier = "customPin"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
            
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                
                // Adicione a cor do pin
                annotationView?.canShowCallout = true // Permite que o callout seja exibido
                                
                // Adicione a cor do pin
                annotationView?.markerTintColor = ColorsExtension.purpleMedium // Cor personalizada do pin
                annotationView?.glyphImage = UIImage(systemName: "cart.fill")
                
                // Adiciona um botão de detalhe ao callout
                let detailButton = UIButton(type: .detailDisclosure)
                annotationView?.rightCalloutAccessoryView = detailButton
            } else {
                annotationView?.annotation = annotation
            }
            return annotationView
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotationTitle = view.annotation?.title else { return }
        delegate?.didTapOnPin(annotationTitle: annotationTitle)
        print("Pin clicado: \(annotationTitle ?? "")")
    }

    // MARK: - Lifecycle

    init() {
        super.init(frame: .zero)
        setup()
        let initialLocation = CLLocation(latitude: -23.55052, longitude: -46.63331)
        let annotation = MKPointAnnotation()
        // ADICIONA O PIN DA COORDENADA
        annotation.coordinate = CLLocationCoordinate2D(latitude: -23.55052, longitude: -46.63331)
        annotation.title = "Mais Variedades"
        mapView.addAnnotation(annotation)
        setInitialLocation(location: initialLocation)
        mapView.delegate = self

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
