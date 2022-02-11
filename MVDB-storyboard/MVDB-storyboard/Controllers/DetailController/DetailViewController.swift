//
//  DetailViewController.swift
//  MVDB-storyboard
//
//  Created by Fedii Ihor on 01.02.2022.
//

import UIKit
import SafariServices
import SDWebImage
import SnapKit

class DetailViewController: UITableViewController {
    
    static let id = "DetailViewController"
    
    var movie: Movie?
    private var videos = [MovieVideo]() {
        didSet {
            print("videos",videos.count)
            refCollectionView.snp.remakeConstraints {
                $0.height.equalTo(37*videos.count + 5)
            }
            refCollectionView.reloadData()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var starringLabel: UILabel!
    @IBOutlet weak var directorsLabel: UILabel!
    
    @IBOutlet weak var refCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      title = "Details"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let movie = self.movie else {return}
        self.setupUI(movie)
        self.setupCollectionView()
    }
    
    private func setupCollectionView() {
        refCollectionView.register(DetailCell.nib(), forCellWithReuseIdentifier: DetailCell.id)
        refCollectionView.delegate = self
        refCollectionView.dataSource = self
    }

    private func setupUI(_ movie: Movie) {
        
        videos = movie.videos?.results ?? []
        
        self.titleLabel.text = movie.title
        self.overviewLabel.text = movie.overview
        self.posterView.layer.cornerRadius = 10
        
        let dateText = String(movie.releaseDate?.split(separator: "-").first ?? "not found")
        let time = movie.runtime ?? 0
        let genre = movie.genreText
        let timeText = "\(genre)・\(dateText)・ \(time/60) hour, \(time%60) minutes"
        self.descriptionLabel.text = timeText
        
        let voteInt = Int(movie.voteAverage)
        let voteStartext = String(repeating: "⭐️", count: voteInt)
        let rateText = ", \(voteInt)/10 - total marks: " + String(movie.voteCount)
        self.voteLabel.text = voteStartext + rateText
        
        let stars = movie.credits?.cast.reduce("") { $0+"\($1.name)\n" } ?? "not found info"
        self.starringLabel.text = stars
        
        let directors = movie.credits?.crew.filter{ $0.job == "Director"}.reduce(""){
            $0+"\($1.name)\n"
        } ?? "not found info"
        self.directorsLabel.text = directors
        
    posterView.sd_setImage(with:movie.backdropURL,  placeholderImage: UIImage(systemName: "photo.fill"))
    }
 
}

extension DetailViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = refCollectionView.dequeueReusableCell(withReuseIdentifier: DetailCell.id, for: indexPath) as! DetailCell
        let item = videos[indexPath.item]
        cell.setupCell(with: item)
        return cell
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        
        guard let url = videos[indexPath.row].youtubeURL else {return}
        let vc = SFSafariViewController(url: url)
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true )
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.size.width - 6
        return CGSize(width: width, height: 32)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
}
