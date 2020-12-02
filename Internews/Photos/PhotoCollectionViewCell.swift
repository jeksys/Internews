//
//  PhotoCollectionViewCell.swift
//  Internews
//
//  Created by Evgeny Yagrushkin on 2020-12-01.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = String(describing: PhotoCollectionViewCell.self)
    var imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray
        
        self.clipsToBounds = true
        self.autoresizesSubviews = true
        
        imageView.frame = self.bounds
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(imageView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func update(with photo: Photo) {
        setImage(from: photo.thumbnailUrl)
    }

    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
}
