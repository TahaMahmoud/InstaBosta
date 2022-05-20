//
//  ProfileViewController.swift
//  InstaBosta
//
//  Created by Taha on 20/05/2022.
//

import UIKit
import RxSwift

class ProfileViewController: UIViewController {

    internal let disposeBag = DisposeBag()
    var viewModel: ProfileViewModel!

    @IBOutlet weak var albumsTableView: UITableView!
    @IBOutlet weak var indicator: BPCircleActivityIndicator!

    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setupTableView()
        // bindTableView()
        
        // bindIndicator()
        bindErrorMessage()
        
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

    func setupTableView() {
        albumsTableView.delegate = self
        albumsTableView.registerCellNib(cellClass: AlbumTableViewCell.self)
    }

    fileprivate func bindTableView() {
        viewModel.albums
            .bind(to: albumsTableView.rx.items(
                    cellIdentifier: "AlbumTableViewCell",
                    cellType: AlbumTableViewCell.self)) { row, element, cell in
                let indexPath = IndexPath(row: row, section: 0)
                        cell.configure(viewModel: self.viewModel.albumViewModelAtIndexPath(indexPath))
            }
            .disposed(by: disposeBag)
        
        albumsTableView.rx.itemSelected.subscribe {[weak self]  (indexPath) in
            guard let indexPath = indexPath.element else { return }
            let cell = self?.albumsTableView.cellForRow(at: indexPath) as? AlbumTableViewCell
            self?.viewModel.didAlbumSelected(indexPath)
        }.disposed(by: disposeBag)
        
    }
    
    func showIndicator() {
        indicator.isHidden = false
        indicator.animate()
    }
        
    func hideIndicator() {
        indicator.isHidden = true
        indicator.stop()
    }

}

extension ProfileViewController: UITableViewDelegate{
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
