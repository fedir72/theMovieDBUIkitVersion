//
//  SearchCell.swift
//  MVDB-storyboard
//
//  Created by Fedii Ihor on 04.02.2022.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
    static let id = "SearchCell"
    static func nib() -> UINib {
        return UINib(nibName: self.id, bundle: nil)
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(with movie: Movie) {
    titleLabel.text = movie.title
        dateLabel.text = movie.releaseDate
    }
}
