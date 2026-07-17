//
//  ImageCollectionViewCell.swift
//  Lecture18
//
//  Created by Lizi Chichua on 17/07/2026.
//

import UIKit
import Kingfisher

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(with movie: Movie) {
        let url = URL(string: "https://image.tmdb.org/t/p/w300\(movie.posterImage)")
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url)
    }
}
