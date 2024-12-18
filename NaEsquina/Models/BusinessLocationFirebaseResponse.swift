//
//  BusinessLocationFirebaseResponse.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 17/12/24.
//

import FirebaseFirestore

struct BusinessLocationFirebaseResponse {
    let name: String
    let latitude: Double
    let longitude: Double
    let documentReference: DocumentReference
}
