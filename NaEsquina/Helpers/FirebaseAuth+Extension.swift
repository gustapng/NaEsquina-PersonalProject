//
//  FirebaseAuth+Extension.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 10/11/24.
//

import FirebaseAuth
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
}
