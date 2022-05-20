//
//  Endponit.swift
//  InstaBosta
//
//  Created by Taha on 20/05/2022.
//

import Foundation
import Moya

protocol BaseEndpoint: TargetType {
    var baseURL: URL { get }
}

extension BaseEndpoint {
    var baseURL: URL {
        return URL(string: Constants.URL.devBaseURL)!
    }
}
