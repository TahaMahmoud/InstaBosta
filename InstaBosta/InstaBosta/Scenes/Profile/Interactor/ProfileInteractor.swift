//
//  ProfileInteractor.swift
//  InstaBosta
//
//  Created by Taha on 20/05/2022.
//

import Foundation
import RxSwift

protocol ProfileInteractorProtocol: AnyObject {
    
    func fetchUsers() -> Observable<[User]>
    func fetchAlbums(userID: Int) -> Observable<[Album]>
    
}

class ProfileInteractor: ProfileInteractorProtocol, NetworkManager {
    
    typealias router = ProfileRequest
    
    func fetchUsers() -> Observable<[User]> {

        return Observable.create {[weak self] (observer) -> Disposable in
            self?.callRequest(target: .users) { ( result: Result<[User], Error>) in
                switch result {
                case .success(let users):
                    observer.onNext(users)
                case .failure(let error):
                    print(error)
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }

    }
    
    func fetchAlbums(userID: Int) -> Observable<[Album]> {
        
        return Observable.create {[weak self] (observer) -> Disposable in
            self?.callRequest(target: .albums(userID: userID)) { ( result: Result<[Album], Error>) in
                switch result {
                case .success(let albums):
                    observer.onNext(albums)
                case .failure(let error):
                    print(error)
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }

    }


}
