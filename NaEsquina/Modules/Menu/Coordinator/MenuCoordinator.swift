//
//  MenuCoordinator.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 24/11/24.
//

import CoreLocation

protocol MenuCoordinator {
    func openNewBusinessSheet(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    func openFilterSheet()
    func navigateToUserView()
    func openBusinessDetailsSheet()
}
