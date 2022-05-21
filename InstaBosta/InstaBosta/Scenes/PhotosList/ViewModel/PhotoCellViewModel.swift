//
//  PhotoCellViewModel.swift
//  InstaBosta
//
//  Created by Taha on 21/05/2022.
//

import Foundation

class PhotoCellViewModel  {
    
    var photoURL: String?
    var thumbnailUrl: String?
    var title: String?

    init(photo: Photo) {
        self.photoURL = photo.url
        self.thumbnailUrl = photo.thumbnailUrl
        self.title = photo.title
    }
    
}
