//
//  WideCell.swift
//  MVDB-storyboard
//
//  Created by Fedii Ihor on 27.01.2022.
//

import UIKit
import SDWebImage

class WideCell: UICollectionViewCell {
    
    static var id = "WideCell"
    static func nib() -> UINib {
        return UINib(nibName: self.id, bundle: nil)
    }
    
    @IBOutlet weak var previeImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(with movie: Movie) {
        let url = movie.backdropURL
        let placeholder = UIImage(systemName: "photo")
        previeImageView.sd_setImage(with: url, placeholderImage: placeholder)
        nameLabel.text = movie.title
        previeImageView.layer.cornerRadius = 10
        previeImageView.layer.shadowRadius = 15
        previeImageView.layer.shadowColor = .init(gray: 0.3, alpha: 1)
    }
}
