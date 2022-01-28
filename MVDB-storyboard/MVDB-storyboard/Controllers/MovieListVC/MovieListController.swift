//
//  ViewController.swift
//  MVDB-storyboard
//
//  Created by Fedii Ihor on 27.01.2022.
//

import UIKit

class MovieListController: UIViewController {

  var collectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
      setupCollectionView()
    }
    
    let layout = UICollectionViewCompositionalLayout { (sectionNumber , env) -> NSCollectionLayoutSection  in
        
        if sectionNumber == 0 {
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let gSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalWidth(0.7))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: gSize, subitems: [item])
        
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            return section
        }else{
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets.trailing = 0
            item.contentInsets.leading = 0
            let gSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalWidth(0.45))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: gSize, subitems: [item])
        
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets.top = 20
                
            section.orthogonalScrollingBehavior = .continuous
            return section
        }
    }
        
    
    
    private func setupCollectionView() {
        self.collectionView = UICollectionView(frame: view.bounds ,
                                               collectionViewLayout: layout)
        self.view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        view.addSubview(collectionView)
        collectionView.register(UINib(nibName: WideCell.id, bundle: nil),
                                forCellWithReuseIdentifier: WideCell.id)
        collectionView.register(UINib(nibName: PortraitCell.id, bundle: nil),
                                forCellWithReuseIdentifier: PortraitCell.id)
        collectionView.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Header.id)
    }


}

extension MovieListController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PortraitCell.id, for: indexPath) as! PortraitCell
            cell.setupCell()
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WideCell.id, for: indexPath) as!WideCell
            cell.setupCell()
            return cell
        }
    }
}

extension MovieListController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.section, indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Header.id, for: indexPath) as! Header
        //header.contentMode = .top
        header.setupHeader()
        return header
    }

}



