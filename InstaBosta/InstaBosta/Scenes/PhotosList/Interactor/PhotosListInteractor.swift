//
//  PhotosListInteractor.swift
//  InstaBosta
//
//  Created by Taha on 21/05/2022.
//

import Foundation
import RxSwift

protocol PhotosListInteractorProtocol: AnyObject {
    
    func fetchPhotos(albumID: Int) -> Observable<[Photo]>

}

class PhotosListInteractor: PhotosListInteractorProtocol, NetworkManager {
    
    typealias router = PhotosListRequest
    
    func fetchPhotos(albumID: Int) -> Observable<[Photo]> {

        return Observable.create {[weak self] (observer) -> Disposable in
            self?.callRequest(target: .photos(albumID: albumID) ) { ( result: Result<[Photo], Error>) in
                switch result {
                case .success(let photos):
                    observer.onNext(photos)
                case .failure(let error):
                    print(error)
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }

    }
    

}
