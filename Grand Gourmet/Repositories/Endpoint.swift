//
//  Endpoint.swift
//  Grand Gourmet
//
//  Created by Indra Permana on 02/06/22.
//

import Alamofire

struct API {

  static let baseUrl = "https://mock.vouchconcierge.com/ios/catalogue/"

}

protocol Endpoint {
    
    var url: String { get }
    var httpMethod: HTTPMethod { get }

}

enum Endpoints: Endpoint {
    
    case home
    case detail
    case cart
    case order
    
    var url: String {
        switch self {
        case .home:
            return "\(API.baseUrl)home"
        case .detail:
            return "\(API.baseUrl)detail"
        case .cart:
            return "\(API.baseUrl)cart"
        case .order:
            return "\(API.baseUrl)order"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
}
