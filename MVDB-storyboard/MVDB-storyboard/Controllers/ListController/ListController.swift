//
//  ListController.swift
//  MVDB-storyboard
//
//  Created by Fedii Ihor on 28.01.2022.
//

import UIKit

class ListController: UIViewController {
    
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

extension ListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PCell.id, for: indexPath) as! PCell
            cell.setupCollectionView()
            return cell
        }else{
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.id, for: indexPath) as! ListCell
        cell.setupCollectionView()
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

extension ListController: UITableViewDelegate {
    
}
