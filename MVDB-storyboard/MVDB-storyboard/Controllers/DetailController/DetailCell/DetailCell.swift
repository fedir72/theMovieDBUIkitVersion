//
//  DetailCell.swift
//  MVDB-storyboard
//
//  Created by Fedii Ihor on 02.02.2022.
//

import UIKit

class DetailCell: UICollectionViewCell {
    
    static let id = "DetailCell"
    static func nib() -> UINib {
        return UINib(nibName: DetailCell.id, bundle: nil)
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 1
        self.layer.borderColor = CGColor.init(gray: 0.5, alpha: 1)
        self.layer.cornerRadius = 10
    }
    
    func setupCell(with video: MovieVideo) {
        nameLabel.text = video.name
    }
}
