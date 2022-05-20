//
//  ProfileCoordinator.swift
//  InstaBosta
//
//  Created by Taha on 20/05/2022.
//

import Foundation
import UIKit

protocol ProfileCoordinatorProtocol: AnyObject {
    func pushToAlbumDetails(with albumID: Int)
}

class ProfileCoordinator: Coordinator{
    
    unowned let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
    }
    
    func start() {
        let profileViewController = ProfileViewController()
        var interactor: ProfileInteractorProtocol?
        let profileViewModel = ProfileViewModel(profileInteractor: ProfileInteractor(), coordinator: self)
        profileViewController.viewModel = profileViewModel
        navigationController.setViewControllers([profileViewController], animated: true)
    }
}

extension ProfileCoordinator: ProfileCoordinatorProtocol {
    
    func pushToAlbumDetails(with albumID: Int) {

    }
        
}
