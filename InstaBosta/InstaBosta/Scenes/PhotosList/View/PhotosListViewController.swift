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
        
    override func viewDidLoad() {
        super.viewDidLoad()

        bindAlbumTitle()
        
        setupCollectionView()
        bindIndicator()
        bindErrorMessage()
        
        bindCollectionView()
        
        bindSearch()
        
        viewModel.viewDidLoad()

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
            let cell = self?.photosCollectionView.cellForItem(at: indexPath) as? PhotoCollectionViewCell
            self?.showFullScreen(photoView: cell?.photoImageView ?? UIImageView())
        }.disposed(by: disposeBag)
        
    }

    func showFullScreen(photoView: UIImageView) {
        let newImageView = UIImageView(image: photoView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }

    @objc func dismissFullscreenImage(sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
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
                .subscribe(onNext: { searchValue in

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
