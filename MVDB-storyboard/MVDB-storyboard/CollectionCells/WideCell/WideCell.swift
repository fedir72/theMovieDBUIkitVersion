//
//  WideCell.swift
//  MVDB-storyboard
//
//  Created by Fedii Ihor on 27.01.2022.
//

import UIKit

class WideCell: UICollectionViewCell {
    
    static let id = "WideCell"
    static func nib() -> UINib {
        return UINib(nibName: self.id, bundle: nil)
    }
    
    @IBOutlet weak var previeImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    setupCell()
    }
    
    func setupCell() {
        previeImageView.layer.cornerRadius = 10
        previeImageView.layer.shadowRadius = 5
    }
}
