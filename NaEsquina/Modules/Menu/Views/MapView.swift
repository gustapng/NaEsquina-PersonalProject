//
//  MapView.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 22/10/24.
//

import MapKit
import UIKit
import RxSwift

protocol MapViewDelegate: AnyObject {
    func didTapOnPin(businessData: BusinessLocationFirebaseResponse)
}

class MapView: UIView, MKMapViewDelegate {

    // MARK: - Coordinator

    var coordinator: CoordinatorFlowController?

    // MARK: - Attributes

    private var temporaryAnnotation: MKPointAnnotation?
    private let disposeBag = DisposeBag()
    private let loadingSubject = BehaviorSubject<Bool>(value: false)
    var isPinConfirmed: Bool = false
    weak var delegate: MapViewDelegate?
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?

    // MARK: - UI Components

    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.pointOfInterestFilter = .excludingAll
        mapView.overrideUserInterfaceStyle = .light
        return mapView
    }()

    private lazy var loadingView: LoadingView = {
        let loading = LoadingView()
        loading.translatesAutoresizingMaskIntoConstraints = false
        return loading
    }()

    // MARK: - Functions

    private func setInitialLocation(location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        self.mapView.setRegion(coordinateRegion, animated: true)
    }

    // MARK: - MKMapViewDelegate

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKPointAnnotation {
            let identifier = "customPin"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView

            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true

                let button = UIButton(type: .detailDisclosure)
                annotationView?.rightCalloutAccessoryView = button
            } else {
                annotationView?.annotation = annotation
            }

            if annotation.subtitle == "temporaryPin" {
                 annotationView?.markerTintColor = ColorsExtension.purpleMedium
            } else {
                // TODO - HERE YOU NEED A LOGIC TO CHANGE ICON ACCORDING TO BUSINESS OPTION
                annotationView?.markerTintColor = ColorsExtension.purpleMedium
                annotationView?.glyphImage = UIImage(systemName: "cart.fill")
            }

            return annotationView
        }
        return nil
    }

    @objc private func handleMapTap(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let controller = delegate as? MenuViewController, controller.isSelectingLocation else { return }

        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)

        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Local Selecionado"
        annotation.subtitle = "temporaryPin"
        self.mapView.addAnnotation(annotation)

        temporaryAnnotation = annotation
        isPinConfirmed = false

        let alertController = UIAlertController(title: "Localização", message: "Deseja adicionar está localização?", preferredStyle: .actionSheet)
        alertController.view.tintColor = ColorsExtension.purpleMedium

        let okAction = UIAlertAction(title: "Sim", style: .default) { UIAlertAction in
            controller.cancelSelection()
            controller.openNewBusinessSheet(latitude: coordinate.latitude, longitude: coordinate.longitude)
        }
        let cancelAction = UIAlertAction(title: "Não", style: .cancel) { UIAlertAction in
            if let annotationToRemove = self.temporaryAnnotation {
                self.mapView.removeAnnotation(annotationToRemove)
            }
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)

        controller.present(alertController, animated: true)
    }

    func removeTemporaryAnnotation() {
        if let annotationToRemove = temporaryAnnotation {
            mapView.removeAnnotation(annotationToRemove)
            temporaryAnnotation = nil
        }
    }

    func mapView(_ mapView: MKMapView,
                 annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {

        DispatchQueue.main.async {
            self.loadingView.startAnimating()
        }

        guard let annotation = view.annotation as? CustomPointAnnotation,
              let documentPath = annotation.documentReference else {
            return
        }

        let documentReference = FirebaseService.shared.db.document("business/\(documentPath)")

        FirebaseStorageService.fetchBusiness(documentReference: documentReference)
            .subscribe(onSuccess: { business in
                self.delegate?.didTapOnPin(businessData: business)
                DispatchQueue.main.async {
                    self.loadingView.stopAnimating()
                }
            }, onFailure: { error in
                print("Erro ao buscar os dados: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.loadingView.stopAnimating()
                }
            })
            .disposed(by: disposeBag)
    }

    func addAnnotations(annotations: [BusinessLocationFirebaseResponse]) {
        mapView.removeAnnotations(mapView.annotations)

        annotations.forEach { business in
            let annotation = CustomPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: business.latitude ?? 0.0, longitude: business.longitude ?? 0.0)
            annotation.title = business.name
            annotation.documentReference = business.documentReference?.documentID
            mapView.addAnnotation(annotation)
        }
    }

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)
        setup()
        let initialLocation = CLLocation(latitude: -23.55052, longitude: -46.63331)
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
        configureGestureRecognizer()
    }

    func addSubviews() {
        addSubview(mapView)
        addSubview(loadingView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor),

            loadingView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: centerYAnchor),
            loadingView.widthAnchor.constraint(equalToConstant: 120),
            loadingView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }

    private func configureGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        tapGesture.delegate = self
        mapView.addGestureRecognizer(tapGesture)
    }
}

extension MapView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
