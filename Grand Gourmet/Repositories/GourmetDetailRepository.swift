//
//  GourmetDetailRepository.swift
//  Grand Gourmet
//
//  Created by Indra Permana on 03/06/22.
//

import Foundation
import Combine
import Alamofire

protocol GourmetDetailRepositoryProtocol {
    func fetchGourmetDetail() -> AnyPublisher<GourmetDetail, Error>
}

struct GourmetDetailRepository: GourmetDetailRepositoryProtocol {
    
    func fetchGourmetDetail() -> AnyPublisher<GourmetDetail, Error> {
        Future<GourmetDetail, Error> { completion in
            if let url = URL(string: Endpoints.detail.url) {
                AF.request(url, method: Endpoints.detail.httpMethod)
                    .validate()
                    .responseDecodable(of: GourmetDetail.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value))
                        case .failure:
                            completion(.failure(NSError(domain: "GourmetDetailRepository Error", code: 400)))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}
