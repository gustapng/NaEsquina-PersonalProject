//
//  AWSService.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 02/12/24.
//

import Foundation
import AWSMobileClient
import AWSS3

final class AWSServiceManager {
    static let shared = AWSServiceManager()

    private init() {
        initializeAWSMobileClient()
    }

    private func initializeAWSMobileClient() {
        // Acessando as credenciais armazenadas nas variáveis de ambiente
        let config = AWSConfig.shared
        
        // Configurando o provedor de credenciais com as variáveis de ambiente
        let credentialsProvider = AWSStaticCredentialsProvider(
            accessKey: config.accessKey,
            secretKey: config.secretKey
        )

        // Configuração do serviço AWS com as credenciais e região
//        let region = AWSRegionType.init(rawValue: "config.region") ?? .USEast1
        let configuration = AWSServiceConfiguration(
            region: .USEast2,
            credentialsProvider: credentialsProvider
        )

        // Inicializando o AWSMobileClient com a configuração personalizada
        AWSMobileClient.default().initialize { (userState, error) in
            if let error = error {
                print("Erro ao inicializar o AWSMobileClient: \(error.localizedDescription)")
            } else {
                print("AWSMobileClient inicializado com sucesso. Estado do usuário: \(String(describing: userState))")
            }
        }
        
        // Registrar o S3 Transfer Utility com a configuração personalizada
        AWSS3TransferUtility.register(
            with: configuration!,
            forKey: "S3TransferUtility"
        )
    }

    func getS3TransferUtility() -> AWSS3TransferUtility {
        return AWSS3TransferUtility.s3TransferUtility(forKey: "S3TransferUtility")!
    }
}
