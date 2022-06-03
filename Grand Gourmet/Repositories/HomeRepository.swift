//
//  HomeRepository.swift
//  Grand Gourmet
//
//  Created by Indra Permana on 02/06/22.
//

import Foundation
import Combine
import Alamofire

protocol HomeRepositoryProtocol {
    func fetchHomeData() -> AnyPublisher<HomeModel, Error>
}

struct HomeRepository: HomeRepositoryProtocol {
    
    func fetchHomeData() -> AnyPublisher<HomeModel, Error> {
        Future<HomeModel, Error> { completion in
            if let url = URL(string: Endpoints.home.url) {
                AF.request(url, method: Endpoints.home.httpMethod)
                    .validate()
                    .responseDecodable(of: HomeModel.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value))
                        case .failure:
                            completion(.failure(NSError(domain: "HomeRepository Error", code: 400)))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}
