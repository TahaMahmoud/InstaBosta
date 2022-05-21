//
//  PhotosListViewController.swift
//  InstaBosta
//
//  Created by Taha on 21/05/2022.
//

import UIKit
import RxSwift
import Kingfisher

class PhotosListViewController: UIViewController {

    internal let disposeBag = DisposeBag()
    var viewModel: PhotosListViewModel!
    
    @IBOutlet weak var albumTitleLabel: UILabel!
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    @IBOutlet weak var indicator: BPCircleActivityIndicator!

    @IBOutlet weak var searchText: UITextField!
        
    @IBOutlet weak var scrollView: ImageScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupZoomScrollView()
        
        bindAlbumTitle()
        
        setupCollectionView()
        bindIndicator()
        bindErrorMessage()
        
        bindCollectionView()
        
        bindSearch()
        
        viewModel.viewDidLoad()

    }
    
    func setupZoomScrollView() {
        scrollView.setup()
        scrollView.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        scrollView.addGestureRecognizer(tap)
    }
    
    func bindIndicator() {
        viewModel.indicator.subscribe { [weak self] status in
            status ? self?.showIndicator() : self?.hideIndicator()
        }.disposed(by: disposeBag)
    }
    
    func bindErrorMessage() {
        viewModel.error.subscribe { message in
            Helper.showErrorNotification(message: message)
        }.disposed(by: disposeBag)
    }

    func bindAlbumTitle() {
        viewModel.albumTitle.subscribe { albumTitle in
            self.albumTitleLabel.text = albumTitle
        }.disposed(by: disposeBag)
    }

    func setupCollectionView() {
        photosCollectionView.delegate = self
        photosCollectionView.registerCellNib(cellClass: PhotoCollectionViewCell.self)
    }

    fileprivate func bindCollectionView() {
        viewModel.photos
            .bind(to: photosCollectionView.rx.items(
                    cellIdentifier: "PhotoCollectionViewCell",
                    cellType: PhotoCollectionViewCell.self)) { row, element, cell in
                let indexPath = IndexPath(row: row, section: 0)
                        cell.configure(viewModel: self.viewModel.photoViewModelAtIndexPath(indexPath))
            }
            .disposed(by: disposeBag)
        
        photosCollectionView.rx.itemSelected.subscribe {[weak self]  (indexPath) in
            guard let indexPath = indexPath.element else { return }
            let photo = self?.viewModel.photoViewModelAtIndexPath(indexPath)
            self?.showFullScreen(photoURL: photo?.photoURL ?? "")
        }.disposed(by: disposeBag)
        
    }

    func showFullScreen(photoURL: String) {
        guard let imageURL = URL(string: photoURL ) else {return}
        let imageView = UIImageView()
        imageView.kf.setImage(with: imageURL)
        guard let image = imageView.image else { return }
        scrollView.display(image: image)
        scrollView.isHidden = false
    }

    @objc func dismissFullscreenImage(sender: UITapGestureRecognizer) {
        scrollView.isHidden = true
    }
    
    func showIndicator() {
        indicator.isHidden = false
        indicator.animate()
    }
        
    func hideIndicator() {
        indicator.isHidden = true
        indicator.stop()
    }

    func bindSearch() {
        searchText.rx.text.orEmpty
            .throttle(RxTimeInterval.seconds(2), latest: true, scheduler: MainScheduler.instance)
                .subscribe(onNext: { [weak self] searchValue in
                    self?.viewModel.search(searchText: searchValue)
                }, onDisposed: nil)
            .disposed(by: disposeBag)
    }
    
    @IBAction func backPressed(_ sender: Any) {
        viewModel.backPressed()
    }
    
}

extension PhotosListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns: CGFloat = 3
        let spacing: CGFloat = 5
        let totalHorizontalSpacing = (columns - 1) * spacing

        let itemWidth = (collectionView.bounds.width - totalHorizontalSpacing) / columns
        let itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        return itemSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
