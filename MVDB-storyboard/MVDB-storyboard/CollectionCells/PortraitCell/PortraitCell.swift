//
//  PortraitCell.swift
//  MVDB-storyboard
//
//  Created by Fedii Ihor on 27.01.2022.
//

import UIKit
import SDWebImage

class PortraitCell: UICollectionViewCell {
    
    static let id = "PortraitCell"
    
    static func nib() -> UINib {
        return UINib(nibName: self.id, bundle: nil)
    }
    
    @IBOutlet weak var previewImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    func setupCell(with movie: Movie) {
        
        let url = movie.posterURL
        let placeholder = UIImage(systemName: "photo")
        previewImageView.sd_setImage(with: url, placeholderImage: placeholder)
     
        previewImageView.layer.cornerRadius = 10
        previewImageView.layer.shadowRadius = 5
    }
}
