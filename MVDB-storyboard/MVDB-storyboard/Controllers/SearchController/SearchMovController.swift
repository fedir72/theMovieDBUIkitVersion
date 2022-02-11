//
//  SearchMovController.swift
//  MVDB-storyboard
//
//  Created by Fedii Ihor on 02.02.2022.
//

import UIKit

class SearchMovController: UITableViewController {
    
    var movies = [Movie]() {
        didSet {
            self.tableView.beginUpdates()
            //collectionView.reloadData()
            self.tableView.endUpdates()
            collectionView.reloadData()
            print(movies.count)
            movies.forEach { m in
                print(m.title)
            }
        }
    }

    @IBOutlet private weak var searchbar: UISearchBar!
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupSearchBar()
    }

    private func setupCollectionView() {
        collectionView.register(SearchCell.nib(), forCellWithReuseIdentifier: SearchCell.id)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupSearchBar() {
        searchbar.showsBookmarkButton = (movies.count == 0 ? false : true)
        searchbar.becomeFirstResponder()
        searchbar.keyboardType = .default
        searchbar.delegate = self
        searchbar.placeholder = "enter film's name"
    }
    
}

extension SearchMovController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return 60
        default: if movies.count == 0 {
            return 0
        }else {
            return CGFloat(movies.count * 55 + 5)
         }
      }
   }
    
}

extension SearchMovController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.id, for: indexPath) as! SearchCell
        let item = movies[indexPath.item]
        cell.setupCell(with: item)
        return cell
        
    }
    
}

extension SearchMovController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = movies[indexPath.item].id
        MovieStore.shared.fetchMovie(id: id) { result in
            switch result {
                
            case .success(let movie):
                let vc = self.storyboard?.instantiateViewController(withIdentifier: DetailViewController.id) as! DetailViewController
                vc.movie = movie
                self.present(vc,animated: true)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widht = view.bounds.size.width - 6
        return CGSize(width: widht, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 3, bottom: 5, right: 3)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    
}

extension SearchMovController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchbar.text ?? "not text")
        let querry = searchbar.text ?? ""
        MovieStore.shared.searchMovie(query: querry) {[weak self] result in
            
            switch result {
            case .success(let value):
                self?.movies = value.results
            case .failure(let error):
                print("Error",error.localizedDescription)
            }
        }
        searchbar.text = ""
    }
}
