//
//  BusinessLocationFirebaseResponse.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 17/12/24.
//

import FirebaseFirestore

struct BusinessLocationFirebaseResponse {
    var name: String?
    var phone: String?
    var address: String?
    var imageUrl: String?
    var image: UIImage?
    var latitude: Double?
    var longitude: Double?
    var documentReference: DocumentReference?
}
