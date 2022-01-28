//
//  HeaderView.swift
//  MVDB-storyboard
//
//  Created by Fedii Ihor on 27.01.2022.
//

import UIKit

class Header: UICollectionReusableView {
    
    static let id = "Header"
    
    let label: UILabel = {
        let l = UILabel()
        l.text = "Многo вкусной еды"
        l.textColor = .white
        l.textAlignment = .center
        return l
    }()
    
  
    public func setupHeader() {
        self.backgroundColor = .cyan
        addSubview(label)
    }
    override func layoutSubviews() {
         super.layoutSubviews()
        label.frame =  self.bounds
    }
    
}
