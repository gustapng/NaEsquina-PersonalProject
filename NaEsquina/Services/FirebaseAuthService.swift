//
//  FirebaseAuthService.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 24/11/24.
//

import Firebase
import FirebaseAuth
import RxSwift

final class FirebaseAuthService {
    private let auth: Auth

    init(auth: Auth = Auth.auth()) {
        self.auth = auth
    }

    func login(email: String, password: String) -> Single<AuthDataResult> {
        return auth.rx.signIn(withEmail: email, password: password)
    }
    
    func signOut() -> Result<Void, Error> {
        do {
            try auth.signOut()
            return .success(())
        } catch {
            return .failure(error)
        }
    }
}
