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
    
    var selectedUser: UserDataViewModel?
    var currentUser: PublishSubject<UserDataViewModel> = .init()
    var albums: BehaviorRelay<[AlbumCellViewModel]> = .init(value: [])

    var indicator: PublishSubject<Bool> = .init()
    var error: PublishSubject<String> = .init()
    
    private let profileInteractor: ProfileInteractorProtocol
    
    init(profileInteractor: ProfileInteractorProtocol = ProfileInteractor(), coordinator: ProfileCoordinatorProtocol) {
        self.profileInteractor = profileInteractor
        self.coordinator = coordinator
    }
    
    func viewDidLoad(){
        
        if Helper.checkConnection() {
            indicator.onNext(true)
            fetchUsers()
            bindFetchAlbums()
        } else {
            error.onNext("Check Internet Connection")
        }

    }
    
    func didAlbumSelected(_ indexPath: IndexPath) {
        let albumID = albums.value[indexPath.row].id ?? 0
        let albumTitle = albums.value[indexPath.row].title ?? ""
        coordinator.pushToAlbumDetails(albumID: albumID, albumTitle: albumTitle)
    }

    func userDataViewModel() -> UserDataViewModel {
        return selectedUser ?? UserDataViewModel(user: User(id: 0, name: "", username: "", email: "", address: Address(street: "", suite: "", city: "", zipcode: "", geo: Geo(lat: "", lng: "")), phone: "", website: "", company: Company(name: "", catchPhrase: "", bs: "")))
    }
    
    func albumViewModelAtIndexPath(_ indexPath: IndexPath) -> AlbumCellViewModel {
        return albums.value[indexPath.row]
    }
    
    private func fetchUsers() {
        profileInteractor.fetchUsers().subscribe{ [weak self] (response) in

            // Select Random User
            guard let currentUser = response.element?.randomElement() else {
                self?.error.onNext("Can't Fetch Users")
                return
            }
            
            self?.currentUser.onNext(UserDataViewModel(user: currentUser))
            
        }.disposed(by: disposeBag)
    }
    
    private func bindFetchAlbums() {
        currentUser.subscribe { [weak self] user in
            
            guard let user = user.element else {
                self?.error.onNext("Can't Fetch Users")
                return
            }
            
            self?.selectedUser = user
            
            self?.fetchAlbums()
        }.disposed(by: disposeBag)
    }
    
    private func fetchAlbums() {
        indicator.onNext(true)
        guard let userID = selectedUser?.id else {
            error.onNext("Can't Fetch Albums")
            return
        }
        
        profileInteractor.fetchAlbums(userID: userID).subscribe{ [weak self] (response) in
            self?.indicator.onNext(false)
            
            // Create Album Cell View Model From Response
            var albums: [AlbumCellViewModel] = []
            for album in response.element ?? [] {
                albums.append(AlbumCellViewModel(album: album))
            }
            
            self?.albums.accept(albums)
            
        }.disposed(by: disposeBag)

    }

}
