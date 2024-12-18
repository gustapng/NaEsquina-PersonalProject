//
//  FirebaseService.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 30/10/24.
//

import FirebaseFirestore

class FirebaseService {
    static let shared = FirebaseService()
    let db = Firestore.firestore()
    
    private init() {}
}
