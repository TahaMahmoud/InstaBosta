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
    var user: UserDataViewModel?
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var visitWebsiteButton: CustomButton!
    
    @IBOutlet weak var albumsLabel: UILabel!
    @IBOutlet weak var separator: UIView!

    @IBOutlet weak var albumsTableView: UITableView!
    @IBOutlet weak var indicator: BPCircleActivityIndicator!

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        bindTableView()
        bindUserData()
        
        bindIndicator()
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
            self?.viewModel.didAlbumSelected(indexPath)
        }.disposed(by: disposeBag)
        
    }
    
    func bindUserData() {
        viewModel.currentUser.subscribe { [weak self] currentUser in
            self?.user = currentUser.element
            self?.renderUser()
        }.disposed(by: disposeBag)
    }
    
    func renderUser() {
        userNameLabel.text = user?.name
        addressLabel.text = user?.address
        phoneLabel.text = user?.phone
        photoImageView.isHidden = false
        visitWebsiteButton.isHidden = false
        albumsLabel.isHidden = false
        separator.isHidden = false
    }
    
    func showIndicator() {
        indicator.isHidden = false
        indicator.animate()
    }
        
    func hideIndicator() {
        indicator.isHidden = true
        indicator.stop()
    }

    @IBAction func websitePressed(_ sender: Any) {
        if let url = URL(string: "https://\(user?.website ?? "bosta.co/")") {
            UIApplication.shared.open(url)
        }
    }
    
    
}

extension ProfileViewController: UITableViewDelegate{
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
}
