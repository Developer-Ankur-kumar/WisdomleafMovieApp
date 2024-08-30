//
//  MovieDetailsViewController.swift
//  WisdomleafMovieApp
//
//  Created by Ankur Kumar on 30/08/24.
//

import UIKit
import Cosmos

class MovieDetailsViewController: UIViewController {
  
    @IBOutlet weak var moviePosterImg:UIImageView!
    @IBOutlet weak var genreLbl:UILabel!
    @IBOutlet weak var runtimeLbl:UILabel!
    @IBOutlet weak var ratedLbl:UILabel!
    @IBOutlet weak var titleLbl:UILabel!
    @IBOutlet weak var plotLbl:UITextView!
    @IBOutlet weak var ratingView:CosmosView!

    
    var selectedMovieID: String?
    private let apiClient = MovieDetailsApiClient()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviePosterImg.contentMode = .scaleAspectFit
        ratingView.settings.totalStars = 10
        ratingView.settings.starSize = 16
        ratingView.settings.fillMode = .half
        fetchMovieDetails()
    }

    func fetchMovieDetails(){
        guard let selectedMovieID else {
            return
        }
        apiClient.fetchMovieDetails(selectedMovieID: selectedMovieID) { [weak self] result in
            switch result {
            case .success(let movie):
                self?.setupData(movie:movie)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
    }
    
    func setupData(movie: MovieDetailResponse?) {
        guard let movieDetails =  movie else { return }
        
        DispatchQueue.main.sync {
            titleLbl.text = movieDetails.title
            plotLbl.text = movieDetails.plot
            genreLbl.text = movieDetails.genre
            runtimeLbl.text = movieDetails.runtime
            ratedLbl.text = movieDetails.imdbRating
            ratingView.rating = Double(movieDetails.imdbRating ?? "0.0") ?? 0.0
            moviePosterImg.kf.setImage(with: movieDetails.posterUrl)
        }
    }
}
