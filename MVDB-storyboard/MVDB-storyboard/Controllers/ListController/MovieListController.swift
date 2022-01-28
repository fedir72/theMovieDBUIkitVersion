//
//  MovieListController.swift
//  MVDB-storyboard
//
//  Created by Fedii Ihor on 28.01.2022.
//

import UIKit

class MovieListController: UIViewController {
    
    private var nowPlaying: [Movie]?
    private var upcoming: [Movie]?
    private var topRated: [Movie]?
    private var popular: [Movie]?
    
    private var datasource: [MovieListEndPoint] = [.nowPlaying,.popular,.topRated, .upcoming]
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTable()
    }
    
    
    private func setupTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.cornerRadius = 15
        tableView.register(ListCell.nib(),forCellReuseIdentifier: ListCell.id)
        tableView.register(PCell.nib(), forCellReuseIdentifier: PCell.id)
    }



}

extension MovieListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PCell.id, for: indexPath) as! PCell
            cell.setupCollectionView(with: datasource[indexPath.row])
            return cell
        }else{
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.id, for: indexPath) as! ListCell
            cell.setupCollectionView(with: datasource[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 350
        }else{
            return 220
        }
        
    }
    
}

extension MovieListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
