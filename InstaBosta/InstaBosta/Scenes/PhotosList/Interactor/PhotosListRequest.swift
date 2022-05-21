//
//  PhotosListRequest.swift
//  InstaBosta
//
//  Created by Taha on 21/05/2022.
//

import Foundation
import Moya

enum PhotosListRequest {
    case photos(albumID: Int)
}

// MARK: - Conforming to BaseRouter
extension PhotosListRequest: BaseEndpoint {
    
    var path: String {
        switch self {
        case .photos:
            return "photos"
        }
    }

    var method: Moya.Method {
        switch self {
        case .photos:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .photos(let albumID):
            return .requestParameters(parameters: [Constants.Parameter.albumID: albumID], encoding: URLEncoding.default)
        }
    }

    var headers: [String : String]? {
        return [Constants.Header.contentType: Constants.ContentType.json]
    }
    
}
