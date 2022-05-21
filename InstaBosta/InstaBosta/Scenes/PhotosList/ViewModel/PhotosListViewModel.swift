//
//  PhotosListViewMode.swift
//  InstaBosta
//
//  Created by Taha on 21/05/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol PhotosListViewModelOutput {
    func photoViewModelAtIndexPath(_ indexPath: IndexPath) -> PhotoCellViewModel
    
    var indicator: PublishSubject<Bool> { get set }
    var error: PublishSubject<String> { get set }
}

protocol PhotosListViewModelInput {
    
    func viewDidLoad()
    func backPressed()
    
}

class PhotosListViewModel: PhotosListViewModelInput, PhotosListViewModelOutput {
    
    private let coordinator: PhotosListCoordinatorProtocol
    let disposeBag = DisposeBag()
        
    var currentAlbumID: Int?
    var currentAlbumTitle: String = ""
    
    var albumTitle: PublishSubject<String> = .init()
    var photos: BehaviorRelay<[PhotoCellViewModel]> = .init(value: [])

    var indicator: PublishSubject<Bool> = .init()
    var error: PublishSubject<String> = .init()
    
    private let photosListInteractor: PhotosListInteractorProtocol
    
    init(photosListInteractor: PhotosListInteractorProtocol = PhotosListInteractor(), coordinator: PhotosListCoordinatorProtocol) {
        self.photosListInteractor = photosListInteractor
        self.coordinator = coordinator
    }
    
    func viewDidLoad(){
        renderAlbumData()
        
        if Helper.checkConnection() {
            indicator.onNext(true)
            fetchPhotos()
        } else {
            error.onNext("Check Internet Connection")
        }

    }
    
    private func fetchPhotos() {
        
        guard let albumID = currentAlbumID else {
            error.onNext("Can't Fetch Album")
            return
        }
                
        photosListInteractor.fetchPhotos(albumID: albumID).subscribe{ [weak self] (response) in
            self?.indicator.onNext(false)
            // Create Album Cell View Model From Response
            var photos: [PhotoCellViewModel] = []
            for photo in response.element ?? [] {
                photos.append(PhotoCellViewModel(photo: photo))
            }
            
            self?.photos.accept(photos)
            
        }.disposed(by: disposeBag)
    }
    
    private func renderAlbumData() {
        albumTitle.onNext(currentAlbumTitle)
    }
    
    func photoViewModelAtIndexPath(_ indexPath: IndexPath) -> PhotoCellViewModel {
        return photos.value[indexPath.row]
    }

    func backPressed() {
        coordinator.backToProfile()
    }
}
