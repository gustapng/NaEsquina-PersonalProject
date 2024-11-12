//
//  FirebaseAuth+Extension.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 10/11/24.
//

import FirebaseFirestore
import RxSwift

extension AuthService {
    
    func saveUserData(username: String, email: String) -> Single<Void> {
        return Single.create { single in
            let data = [
                "username": username,
                "email": email,
                "createdAt": Timestamp(date: Date())
            ]
            
            Firestore.firestore().collection("users").document(email).setData(data) { error in
                if let error = error {
                    single(.failure(error))
                } else {
                    single(.success(()))
                }
            }
            
            return Disposables.create()
        }
    }
}
