//
//  PCell.swift
//  MVDB-storyboard
//
//  Created by Fedii Ihor on 28.01.2022.
//

import UIKit
class PCell: UITableViewCell, MovieCellProtocol  {
    
    
    static let id = "PCell"
    static func nib() -> UINib {
        return UINib(nibName: self.id, bundle: nil)
    }
    
    var movieData = [Movie]() {
        didSet { collectionView.reloadData()}
    }
    
    
    private var endpoint: MovieListEndPoint? {
        didSet {
            guard let endpoint = endpoint else { return }
            MovieStore.shared.fetchMovies(from: endpoint) { result in
                switch result {
                case .success(let value):
                    print(value)
                    self.movieData = value.results
                case .failure(let error):
                    print(error.localizedDescription)
          }
        }
      }
    }
    
    @IBOutlet weak var sectionCaseLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupCollectionView(with endpoint: MovieListEndPoint) {
        self.sectionCaseLabel.text = endpoint.description
        self.endpoint = endpoint
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register( PortraitCell.nib(), forCellWithReuseIdentifier: PortraitCell.id)
        }
   }


extension PCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieData.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PortraitCell.id, for: indexPath) as! PortraitCell
        cell.setupCell(with: movieData[indexPath.row])
            return cell
    }
}

extension PCell: UICollectionViewDelegate ,  UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let h = self.collectionView.frame.height - 4
        let v = h/1.6
        return CGSize(width: v, height:  h )
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 15, bottom: 0, right: 15)
    }
}
