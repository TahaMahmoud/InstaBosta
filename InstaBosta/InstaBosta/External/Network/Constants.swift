//
//  Constants.swift
//  InstaBosta
//
//  Created by Taha on 20/05/2022.
//

import Foundation

struct Constants {
    
    // static let apiKey = "d17378e37e555ebef55ab86c4180e8dc"

    enum URL {
        static let devBaseURL = "https://jsonplaceholder.typicode.com"
        static let testBaseURL = "https://jsonplaceholder.typicode.com"
        static let prodBaseURL = "https://jsonplaceholder.typicode.com"
    }

    enum Header {
        static let contentType = "Content-Type"
    }

    enum ContentType {
        static let json = "application/json"
    }

    enum Path {
        static let users = "users"
        static let albums = "albums"
        static let photos = "photos"
    }

    enum Parameter {
        static let userID = "userId"
        static let albumID = "albumId"
    }

}

