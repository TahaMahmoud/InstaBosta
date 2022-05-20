//
//  AlbumTableViewCell.swift
//  InstaBosta
//
//  Created by Taha on 20/05/2022.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    var albumID: Int?
    @IBOutlet weak var albumTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(viewModel: AlbumCellViewModel) {
        self.albumID = viewModel.id ?? 0
        self.albumTitle.text = viewModel.title ?? ""
    }

}
