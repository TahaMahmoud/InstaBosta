//
//  ProfileViewModel.swift
//  InstaBosta
//
//  Created by Taha on 20/05/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol ProfileViewModelOutput {
    func userDataViewModel() -> UserDataViewModel
    func albumViewModelAtIndexPath(_ indexPath: IndexPath) -> AlbumCellViewModel

    var indicator: PublishSubject<Bool> { get set }
    var error: PublishSubject<String> { get set }
}

protocol ProfileViewModelInput {
    
    func viewDidLoad()
    func didAlbumSelected(_ indexPath: IndexPath)
    
}

class ProfileViewModel: ProfileViewModelOutput, ProfileViewModelInput {
    
    private let coordinator: ProfileCoordinatorProtocol
    let disposeBag = DisposeBag()
        
    var albums: BehaviorRelay<[AlbumCellViewModel]> = .init(value: [])

    var indicator: PublishSubject<Bool> = .init()
    var error: PublishSubject<String> = .init()
    
    private let profileInteractor: ProfileInteractorProtocol
    
    init(profileInteractor: ProfileInteractorProtocol = ProfileInteractor(), coordinator: ProfileCoordinatorProtocol) {
        self.profileInteractor = profileInteractor
        self.coordinator = coordinator
    }
    
    func viewDidLoad(){
        print("Initialized")
    }
    
    func didAlbumSelected(_ indexPath: IndexPath) {
        
    }

    func userDataViewModel() -> UserDataViewModel {
        return UserDataViewModel(user: User(id: 0, name: "", username: "", email: "", address: Address(street: "", suite: "", city: "", zipcode: "", geo: Geo(lat: "", lng: "")), phone: "", website: "", company: Company(name: "", catchPhrase: "", bs: "")))
    }
    
    func albumViewModelAtIndexPath(_ indexPath: IndexPath) -> AlbumCellViewModel {
        return AlbumCellViewModel(album: Album(userID: 0, id: 0, title: ""))
    }
}
