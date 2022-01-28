//
//  PortraitCell.swift
//  MVDB-storyboard
//
//  Created by Fedii Ihor on 27.01.2022.
//

import UIKit

class PortraitCell: UICollectionViewCell {
    
    static let id = "PortraitCell"
    
    static func nib() -> UINib {
        return UINib(nibName: self.id, bundle: nil)
    }
    
    @IBOutlet weak var previewImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    func setupCell() {
        previewImageView.layer.cornerRadius = 10
        previewImageView.layer.shadowRadius = 5
    }
}
