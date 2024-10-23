import UIKit
import MapKit

class MainMenuViewController: UIViewController, MapViewDelegate {

    // MARK: - UI Components

    private lazy var backButton: UIButton = {
        return UIButton.createCustomBackButton(target: self,
                                               action: #selector(backButtonTapped),
                                               borderColor: ColorsExtension.lightGray ?? .black)
    }()

//    private lazy var mapView: MKMapView = {
//        let mapView = MKMapView()
//        mapView.translatesAutoresizingMaskIntoConstraints = false
//        mapView.pointOfInterestFilter = .excludingAll
//        return mapView
//    }()
    
    private lazy var mapView: MapView = {
        let map = MapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()

    private lazy var bottomBar: UITabBar = {
        let tabBar = UITabBar()
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        tabBar.unselectedItemTintColor = ColorsExtension.purpleMedium
        tabBar.tintColor = ColorsExtension.purpleMedium
        tabBar.barTintColor = .white
        tabBar.delegate = self

        let homeItem = UITabBarItem(title: "Adicionar", image: UIImage(systemName: "plus.circle"), tag: 0)
        let filterItem = UITabBarItem(title: "Filtro", image: UIImage(systemName: "line.3.horizontal.decrease.circle"), tag: 1)
        let perfilItem = UITabBarItem(title: "Perfil", image: UIImage(systemName: "person"), tag: 2)

        tabBar.items = [homeItem, filterItem, perfilItem]
        return tabBar
    }()

    // MARK: - Actions
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func openSheetAddBusiness() {
        let businessViewController = AddBusinessViewController()
        if let sheet = businessViewController.sheetPresentationController {
            sheet.detents = [.custom(resolver: { context in return 600 })]
            sheet.prefersGrabberVisible = true
        }
        present(businessViewController, animated: true, completion: nil)
    }
    
    func didTapOnPin(annotationTitle: String?) {
        let sheetViewController = BusinessDetailsViewController()
        if let sheet = sheetViewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        present(sheetViewController, animated: true, completion: nil)
    }

    @objc func openSheetFilter() {
        let sheetViewController = FilterViewController()
        if let sheet = sheetViewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        present(sheetViewController, animated: true, completion: nil)
    }

    @objc func goToUserView() {
        let userViewController = UserViewController()
        navigationController?.pushViewController(userViewController, animated: true)
    }

//    private func setInitialLocation(location: CLLocation, regionRadius: CLLocationDistance = 1000) {
//        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
//        mapView.setRegion(coordinateRegion, animated: true)
//    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
//        let initialLocation = CLLocation(latitude: -23.55052, longitude: -46.63331)
//        let annotation = MKPointAnnotation()
//        // ADICIONA O PIN DA COORDENADA
//        annotation.coordinate = CLLocationCoordinate2D(latitude: -23.55052, longitude: -46.63331)
//        mapView.addAnnotation(annotation)
//        setInitialLocation(location: initialLocation)
        setup()
    }
}

extension MainMenuViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            openSheetAddBusiness()
        case 1:
            openSheetFilter()
        case 2:
            goToUserView()
        default:
            break
        }
    }
}

extension MainMenuViewController: SetupView {
    func setup() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        view.addSubview(backButton)
        view.addSubview(mapView)
        view.addSubview(bottomBar)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),

            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: bottomBar.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            bottomBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomBar.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
