//
//  GetAddressFromCoordinates.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 23/12/24.
//

import CoreLocation

func getAddressFromCoordinates(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> String? {
    let geocoder = CLGeocoder()
    let location = CLLocation(latitude: latitude, longitude: longitude)

    let placemarks = try await geocoder.reverseGeocodeLocation(location)

    guard let placemark = placemarks.first else {
        return nil
    }

    var address = ""

    if let street = placemark.thoroughfare {
        address += street
    }

    if let number = placemark.subThoroughfare {
        address += ", \(number)"
    }

    if let city = placemark.locality {
        address += " - \(city)"
    }

    if let state = placemark.administrativeArea {
        address += " - \(state)"
    }

    if let country = placemark.country {
        address += ", \(country)"
    }

    return address
}
