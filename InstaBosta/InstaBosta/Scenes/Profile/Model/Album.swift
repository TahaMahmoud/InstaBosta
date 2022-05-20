//
//  Album.swift
//  InstaBosta
//
//  Created by Taha on 20/05/2022.
//

import Foundation

// MARK: - AlbumElement
struct Album: Codable {
    let userID, id: Int?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case userID
        case id, title
    }
}
