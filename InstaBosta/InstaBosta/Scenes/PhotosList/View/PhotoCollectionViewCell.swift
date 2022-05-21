//
//  PhotoCollectionViewCell.swift
//  InstaBosta
//
//  Created by Taha on 21/05/2022.
//

import UIKit
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: CornerRadiusImage!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(viewModel: PhotoCellViewModel) {
        guard let imageURL = URL(string: viewModel.thumbnailUrl ?? "") else {return}
        photoImageView.kf.setImage(with: imageURL)
    }

}
