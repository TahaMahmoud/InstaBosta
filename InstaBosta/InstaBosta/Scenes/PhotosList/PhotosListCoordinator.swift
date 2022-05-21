//
//  PhotosListCoordinator.swift
//  InstaBosta
//
//  Created by Taha on 21/05/2022.
//

import Foundation
import UIKit

protocol PhotosListCoordinatorProtocol: AnyObject {
    func pushToPhotoDetails(with photo: String)
    func backToProfile()
}

class PhotosListCoordinator: Coordinator{
    
    unowned let navigationController: UINavigationController
    var albumID: Int?
    var albumTitle: String = ""
    
    init(navigationController: UINavigationController, albumID: Int, albumTitle: String) {
        self.navigationController = navigationController
        self.albumID = albumID
        self.albumTitle = albumTitle
    }
    
    func start() {
        let photosListViewController = PhotosListViewController()
        let interactor: PhotosListInteractorProtocol = PhotosListInteractor()
        let photosListViewModel = PhotosListViewModel(photosListInteractor: interactor, coordinator: self)
        photosListViewModel.currentAlbumID = self.albumID
        photosListViewModel.currentAlbumTitle = self.albumTitle
        photosListViewController.viewModel = photosListViewModel
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(photosListViewController, animated: true)
    }
}

extension PhotosListCoordinator: PhotosListCoordinatorProtocol {
    
    func pushToPhotoDetails(with photo: String) {
        
    }
    
    func backToProfile() {
        navigationController.popViewController(animated: true)
    }

        
}
