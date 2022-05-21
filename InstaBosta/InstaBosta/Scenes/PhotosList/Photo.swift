//
//  Photo.swift
//  InstaBosta
//
//  Created by Taha on 21/05/2022.
//

// MARK: - PhotoElement
struct Photo: Codable {
    let albumID, id: Int?
    let title: String?
    let url, thumbnailUrl: String?

    enum CodingKeys: String, CodingKey {
        case albumID
        case id, title, url
        case thumbnailUrl
    }
}
