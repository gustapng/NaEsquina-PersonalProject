//
//  FirebaseAuth+Extension.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 10/11/24.
//

import FirebaseAuth
import FirebaseFirestore
import RxSwift

extension Reactive where Base: Auth {

    func signIn(withEmail email: String, password: String) -> Single<AuthDataResult> {
        return Single.create { single in
            self.base.signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    single(.failure(error))
                } else if let authResult = authResult {
                    single(.success(authResult))
                }
            }
            return Disposables.create()
        }
    }

    func createUser(withEmail email: String, password: String) -> Single<AuthDataResult> {
        return Single.create { single in
            self.base.createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    single(.failure(error))
                } else if let authResult = authResult {
                    single(.success(authResult))
                }
            }
            return Disposables.create()
        }
    }

    func sendPasswordReset(withEmail email: String) -> Single<Void> {
        return Single.create { single in
            self.base.sendPasswordReset(withEmail: email) { error in
                if let error = error {
                    single(.failure(error))
                } else {
                    single(.success(()))
                }
            }
            return Disposables.create()
        }
    }

    func saveUserData(username: String, email: String) -> Single<Void> {
        return Single.create { single in
            let userData = [
                "username": username,
                "email": email,
                "createdAt": Timestamp(date: Date())
            ]

            FirebaseService.shared.db.collection("users").document(email).setData(userData) { error in
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
