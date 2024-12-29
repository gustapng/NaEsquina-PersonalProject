//
//  FirebaseService.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 30/10/24.
//

import FirebaseFirestore
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
        // Your storage url here
        self.storage = Storage.storage(url: "")
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

    static func fetchAllBusiness() -> Single<[BusinessLocationFirebaseResponse]> {
       return Single.create { single in
           var allBusiness: [BusinessLocationFirebaseResponse] = []

           FirebaseService.shared.db.collection("business").getDocuments { (querySnapshot, error) in
               if let error = error {
                   single(.failure(error))
                   return
               }

               guard let documents = querySnapshot?.documents else {
                   single(.failure(NSError(domain: "FirebaseError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Nenhum documento encontrado."])))
                   return
               }

               for document in documents {
                   let data = document.data()
                   if let latitude = data["latitude"] as? Double,
                      let longitude = data["longitude"] as? Double,
                      let name = data["name"] as? String {

                       let businessLocation = BusinessLocationFirebaseResponse (
                           name: name,
                           latitude: latitude,
                           longitude: longitude,
                           documentReference: document.reference
                       )
                       allBusiness.append(businessLocation)
                   }
               }

               single(.success(allBusiness))
           }

           return Disposables.create()
       }
    }

    static func fetchBusiness(documentReference: DocumentReference) -> Single<BusinessLocationFirebaseResponse> {
        return Single.create { single in
            Task {
                do {
                    let document = try await documentReference.getDocument()

                    guard let data = document.data() else {
                        throw NSError(domain: "FirebaseError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Documento não encontrado."])
                    }

                    if let latitude = data["latitude"] as? Double,
                       let longitude = data["longitude"] as? Double,
                       let name = data["name"] as? String,
                       let phone = data["phone"] as? String,
                       let imageUrl = data["imageUrl"] as? String {

                        let address = try await getAddressFromCoordinates(latitude: latitude, longitude: longitude)
                        let image = await loadImage(from: imageUrl)

                        let businessLocation = BusinessLocationFirebaseResponse(
                            name: name,
                            phone: phone,
                            address: address,
                            imageUrl: imageUrl,
                            image: image,
                            latitude: latitude,
                            longitude: longitude,
                            documentReference: documentReference
                        )

                        single(.success(businessLocation))
                    } else {
                        throw NSError(domain: "FirebaseError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Erro ao processar dados do documento."])
                    }
                } catch {
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }

    private static func loadImage(from url: String) async -> UIImage? {
        let httpsReference = FirebaseStorageService.shared.storage.reference(forURL: url)

        return await withCheckedContinuation { continuation in
            httpsReference.getData(maxSize: 10 * 1024 * 1024) { data, error in
                if let error = error {
                    print("Erro ao buscar imagem: \(error.localizedDescription)")
                    continuation.resume(returning: nil)
                } else if let data = data, let image = UIImage(data: data) {
                    continuation.resume(returning: image)
                } else {
                    continuation.resume(returning: nil)
                }
            }
        }
    }
}
