//
//  MovieCellProtocol.swift
//  MVDB-storyboard
//
//  Created by Fedii Ihor on 28.01.2022.
//

import Foundation

protocol MovieCellProtocol: AnyObject {
    func setupCollectionView(with endpoint: MovieListEndPoint)
}
