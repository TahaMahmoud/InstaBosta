//
//  ProfileRequest.swift
//  InstaBosta
//
//  Created by Taha on 20/05/2022.
//

import Foundation
import Moya

enum ProfileRequest {
    case users
    case albums(userID: Int)
}

// MARK: - Conforming to BaseRouter
extension ProfileRequest: BaseEndpoint {
    
    var path: String {
        switch self {
        case .users:
            return "users"
        case .albums:
            return "albums"
        }
    }

    var method: Moya.Method {
        switch self {
        case .users:
            return .get
        case .albums:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .users:
            return .requestPlain
        case .albums(let userID):
            return .requestParameters(parameters: [Constants.Parameter.userID: userID], encoding: URLEncoding.default)
        }
    }

    var headers: [String : String]? {
        return [Constants.Header.contentType: Constants.ContentType.json]
    }
    
}
