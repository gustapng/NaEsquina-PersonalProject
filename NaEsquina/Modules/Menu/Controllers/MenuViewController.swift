import MapKit
import UIKit

class MenuViewController: UIViewController, MapViewDelegate {

    // MARK: - Coordinator

    var coordinator: CoordinatorFlowController?

    // MARK: - Attributes

    var isSelectingLocation = false

    // MARK: - UI Components

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
    
    private lazy var selectionBar: UIView = {
        let view = UIView()
        view.backgroundColor = ColorsExtension.gray?.withAlphaComponent(0.7)
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true

        let label = UILabel()
        label.text = "Toque no mapa para selecionar o local"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false

        let icon = UIImage(systemName: "xmark.circle")

        let cancelButton = UIButton(type: .system)
        cancelButton.setImage(icon, for: .normal)
        cancelButton.imageView?.contentMode = .scaleAspectFit
        cancelButton.tintColor = ColorsExtension.red
        cancelButton.setTitleColor(.red, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelSelection), for: .touchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(label)
        view.addSubview(cancelButton)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            cancelButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        return view
    }()

    // MARK: - Functions

    @objc func openSheetAddBusiness() {
//        button.addTarget(self, action: #selector(showSelectionBar), for: .touchUpInside)
//        self.coordinator?.goToAddBusinessView()
    }

    func didTapOnPin(annotationTitle: String?) {
        openBusinessDetailsSheet()
    }

    @objc func openSheetFilter() {
        openFilterSheet()
    }

    @objc func navigateToRegisterViewController() {
        navigateToUserView()
    }
    
    func showWelcomeMessage() {
        showAlert(on: self, title: "Bem-vindo!", message: "Login realizado com sucesso!")
    }

    @objc func showSelectionBar() {
        isSelectingLocation = true
        selectionBar.isHidden = false
    }

    @objc func cancelSelection() {
        isSelectingLocation = false
        selectionBar.isHidden = true
//        mapView.removeAnnotations(mapView.annotations)
    }

    // MARK: - Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setup()
    }
}

extension MenuViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            showSelectionBar()
//            openSheetAddBusiness()
        case 1:
            openSheetFilter()
        case 2:
            navigateToRegisterViewController()
        default:
            break
        }
    }
}

extension MenuViewController: SetupView {
    func setup() {
        navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        view.addSubview(mapView)
        view.addSubview(bottomBar)
        view.addSubview(selectionBar)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: bottomBar.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            selectionBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            selectionBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            selectionBar.bottomAnchor.constraint(equalTo: bottomBar.topAnchor, constant: -34),
            selectionBar.heightAnchor.constraint(equalToConstant: 50),

            bottomBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomBar.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

extension MenuViewController: MenuCoordinator {
    func openFilterSheet() {
        coordinator?.openFilterSheet()
    }

    func openBusinessDetailsSheet() {
        coordinator?.openBusinessDetailsSheet()
    }

    func navigateToUserView() {
        coordinator?.navigateToUserView()
    }
}
