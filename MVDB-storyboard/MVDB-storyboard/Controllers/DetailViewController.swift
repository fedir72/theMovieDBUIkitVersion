//
//  DetailViewController.swift
//  MVDB-storyboard
//
//  Created by Fedii Ihor on 01.02.2022.
//

import UIKit
import SDWebImage

class DetailViewController: UITableViewController {
    
    static let id = "DetailViewController"
    
    var movie: Movie?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupUI(movie!)
    }

    func setupUI(_ movie: Movie) {
        self.titleLabel.text = movie.title
        self.overviewLabel.text = movie.overview
        self.posterView.layer.cornerRadius = 10
        let dateText = String(movie.releaseDate?.split(separator: "-").first ?? "2022")
        
        let time = movie.runtime ?? 0
        let timeText = "\(dateText)・ \(time/60)hour, \(time%60)minutes"
        self.descriptionLabel.text = timeText
        
        let voteInt = Int(movie.voteAverage)
        let voteStartext = String(repeating: "⭐️", count: voteInt)
        let rateText = ", \(voteInt)/10 - total marks: " + String(movie.voteCount)
        self.voteLabel.text = voteStartext + rateText
        
        posterView.sd_setImage(with:movie.backdropURL,  placeholderImage: UIImage(systemName: "photo.fill"))
    }
 
}

extension DetailViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
