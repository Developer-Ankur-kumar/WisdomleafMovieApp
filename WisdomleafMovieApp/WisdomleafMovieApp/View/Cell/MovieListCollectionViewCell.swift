//
//  MovieListCollectionViewCell.swift
//  WisdomleafMovieApp
//
//  Created by Ankur Kumar on 30/08/24.
//

import UIKit
import Kingfisher

class MovieListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var moviePosterImg:UIImageView!
    @IBOutlet weak var titleLbl:UILabel!
    @IBOutlet weak var yearLbl:UILabel!
    @IBOutlet weak var saveFavoriteButton:UIButton!
    
    weak var delegate: MovieListCollectionViewCellDelegate?
    private var movie: MovieListModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI() {
        cornerRadius(12)
    }
    
    func productDetailConfiguration(movie: MovieListModel?) {
        self.movie = movie
        guard let movie = movie else {
            return
        }
        
        titleLbl.text = movie.title
        yearLbl.text = movie.year
        moviePosterImg.kf.setImage(with: movie.imageUrl)
        setupFav(isFav: movie.isFavourite)
    }
    
    func setupFav(isFav: Bool) {
        saveFavoriteButton.setImage(UIImage(systemName: isFav ? "heart.fill" : "heart"), for: .normal)
    }
    
    @IBAction func favoriteHeartButtonAction(_sender:UIButton){
        guard let movie = movie else {
            return
        }
        
        setupFav(isFav: !movie.isFavourite)
        delegate?.didTapFavoriteButton(on: self, movie: movie)
    }
    
}

