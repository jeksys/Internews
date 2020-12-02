//
//  PhotosCollectionViewController.swift
//  Internews
//
//  Created by Evgeny Yagrushkin on 2020-12-01.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {

    let networkManager: NetworkManagerProtocol
    private var photos = [Photo]()
    private let albumId: Int
    
    init(collectionViewLayout layout: UICollectionViewLayout, albumId: Int, networkManager: NetworkManagerProtocol) {
        self.albumId = albumId
        self.networkManager = networkManager
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        reloadData()
    }

    private func setupView() {
        title = "Photos"
        collectionView.backgroundColor = .white
        self.collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.cellIdentifier)
    }
    
    private func reloadData() {
        networkManager.getPhotos(with: albumId) { photos, error in
            DispatchQueue.main.async {
                self.photos = photos
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.cellIdentifier, for: indexPath)
        
        let photo = photos[indexPath.row]
        (cell as? PhotoCollectionViewCell)?.update(with: photo)
        return cell
    }

}
