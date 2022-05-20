//
//  NetworkManager.swift
//  InstaBosta
//
//  Created by Taha on 20/05/2022.
//

import Foundation
import Moya

protocol NetworkManager {
    associatedtype router: BaseEndpoint
    func callRequest<T: Codable>(target: router, onComplete: @escaping (Result<T, Error>) -> Void)
}

extension NetworkManager {
    
    func callRequest<T: Codable>(target: router, onComplete: @escaping (Result<T, Error>) -> Void) {
        let provider = MoyaProvider<router>()
        provider.request(target, callbackQueue: DispatchQueue.main) { response in
            do {
                guard let statusCode = try? response.get().statusCode else {return}
                switch statusCode {
                case 200:
                    let model = try JSONDecoder().decode(T.self, from: response.get().data)
                    onComplete(.success(model))
                case 403:
                    onComplete(.failure(NetworkError.forbidden))
                default:
                    onComplete(.failure(NetworkError.somethingWentWrong))
                }
            } catch {
                onComplete(.failure(NetworkError.somethingWentWrong))
            }
        }
    }
}
