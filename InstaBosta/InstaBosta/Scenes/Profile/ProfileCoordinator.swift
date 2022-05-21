//
//  ProfileCoordinator.swift
//  InstaBosta
//
//  Created by Taha on 20/05/2022.
//

import Foundation
import UIKit

protocol ProfileCoordinatorProtocol: AnyObject {
    func pushToAlbumDetails(albumID: Int, albumTitle: String)
}

class ProfileCoordinator: Coordinator{
    
    unowned let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
    }
    
    func start() {
        let profileViewController = ProfileViewController()
        let interactor = ProfileInteractor()
        let profileViewModel = ProfileViewModel(profileInteractor: interactor, coordinator: self)
        profileViewController.viewModel = profileViewModel
        navigationController.navigationBar.isHidden = true
        navigationController.setViewControllers([profileViewController], animated: true)
    }
}

extension ProfileCoordinator: ProfileCoordinatorProtocol {
    
    func pushToAlbumDetails(albumID: Int, albumTitle: String) {
        let photosListViewCoordinator = PhotosListCoordinator(navigationController: navigationController, albumID: albumID, albumTitle: albumTitle)
        photosListViewCoordinator.start()
    }
        
}
