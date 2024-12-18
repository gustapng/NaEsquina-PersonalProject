//
//  FirebaseService.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 30/10/24.
//

import FirebaseStorage
import Foundation
import FirebaseCore
import UIKit
import RxSwift
import CoreLocation

class FirebaseStorageService {
    static let shared = FirebaseStorageService()

    let storage: Storage
    let storageRef: StorageReference

    private init() {
        self.storage = Storage.storage(url: "gs://naesquina-f331d.firebasestorage.app")
        self.storageRef = storage.reference()
    }

    func uploadImage(image: UIImage) -> Single<String> {
        return Single.create { single in
            let imageRef = self.storageRef.child("images/\(UUID().uuidString).jpg")

            if let imageData = image.jpegData(compressionQuality: 0.8) {
                imageRef.putData(imageData, metadata: nil) { metadata, error in
                    if let error = error {
                        single(.failure(error))
                        return
                    }

                    imageRef.downloadURL { url, error in
                        if let error = error {
                            single(.failure(error))
                            return
                        }

                        if let imageUrl = url?.absoluteString {
                            single(.success(imageUrl))
                        } else {
                            single(.failure(NSError(domain: "FirebaseError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Erro desconhecido ao recuperar URL."])))
                        }
                    }
                }
            } else {
                single(.failure(NSError(domain: "InvalidImage", code: 0, userInfo: [NSLocalizedDescriptionKey: "Erro ao processar a imagem."])))
            }

            return Disposables.create()
        }
    }

    func saveBusinessData(name: String,
                          phone: String,
                          businessType: String,
                          latitude: CLLocationDegrees,
                          longitude: CLLocationDegrees,
                          imageUrl: String) -> Single<Void> {

        return Single.create { single in
            let businessData: [String: Any] = [
                "name": name,
                "phone": phone,
                "businessType": businessType,
                "latitude": latitude,
                "longitude": longitude,
                "imageUrl": imageUrl,
                "createdAt": Timestamp(date: Date())
            ]

            FirebaseService.shared.db.collection("business").addDocument(data: businessData) { error in
                if let error = error {
                    single(.failure(error))
                } else {
                    single(.success(()))
                }
            }

            return Disposables.create()
        }
    }
    
    static func fetchAllBusiness(completion: @escaping ([BusinessLocationFirebaseResponse]?) -> Void) {
        var allBusiness: [BusinessLocationFirebaseResponse] = []

        FirebaseService.shared.db.collection("business").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Erro ao buscar negócios: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let documents = querySnapshot?.documents else {
                print("Nenhum documento encontrado na coleção.")
                completion(nil)
                return
            }

            for document in documents {
                let data = document.data()
                
                if let latitude = data["latitude"] as? Double,
                   let longitude = data["longitude"] as? Double,
                   let name = data["name"] as? String {
                   let businessLocation = BusinessLocationFirebaseResponse(
                        name: name,
                        latitude: latitude,
                        longitude: longitude,
                        documentReference: document.reference
                    )
                    allBusiness.append(businessLocation)
                }
            }

            completion(allBusiness)
        }
    }
}