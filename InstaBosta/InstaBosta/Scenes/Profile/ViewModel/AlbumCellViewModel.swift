//
//  AlbumCellViewModel.swift
//  InstaBosta
//
//  Created by Taha on 20/05/2022.
//

import Foundation

class AlbumCellViewModel  {
    
    var id: Int?
    var title: String?
    
    init(album: Album) {
        self.id = album.id ?? 0
        self.title = album.title ?? ""
    }
    
}
