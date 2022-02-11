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
        
        let cornerradius: CGFloat = 10
        
        previeImageView.layer.shadowColor = UIColor.gray.cgColor
        previeImageView.layer.cornerRadius = cornerradius
        //previeImageView.layer.shadowRadius = 5.0
        //previeImageView.layer.shadowOpacity = 0.7
        //previeImageView.layer.shadowOffset = .init(width: 5, height: 5)
        
        previeImageView.clipsToBounds =  true
        
//        let cgPath =  UIBezierPath(roundedRect: previeImageView.bounds,
//                                   byRoundingCorners: [.allCorners],
//                                   cornerRadii: CGSize(width: cornerradius, height: cornerradius)).cgPath
//        previeImageView.layer.shadowPath = cgPath
    
    }
}
