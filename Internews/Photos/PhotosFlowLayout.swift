//
//  Photos.swift
//  Internews
//
//  Created by Evgeny Yagrushkin on 2020-12-01.
//

import UIKit

class PhotosFlowLayout: UICollectionViewFlowLayout {

    static let numberOfColumns = 3
    
    override func prepare() {
        super.prepare()

        guard let collectionView = collectionView else { return }
        
        sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        minimumInteritemSpacing = 10
        minimumLineSpacing = 10
        
        let availableWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width - sectionInset.left - sectionInset.right - minimumInteritemSpacing
        let cellSize = (availableWidth / CGFloat(PhotosFlowLayout.numberOfColumns)).rounded(.down)
        
        self.itemSize = CGSize(width: cellSize, height: cellSize)
        self.sectionInsetReference = .fromSafeArea
    }
        
}
