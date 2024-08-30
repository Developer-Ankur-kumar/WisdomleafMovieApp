//
//  File.swift
//  WisdomleafMovieApp
//
//  Created by Ankur Kumar on 30/08/24.
//

import Foundation


extension MovieListViewController: MovieListCollectionViewCellDelegate {
    func didTapFavoriteButton(on cell: MovieListCollectionViewCell, movie: MovieListModel) {
        defer {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        /// This will update local storage with favourite state i.e 'true' or 'false' with respect to movieID
        upadateDataStorage(isFav: movie.isFavourite, movieID: movie.imdbID)
        
        /// This will reverse the current favourite state i.e if it is fav then it will make it un-favourite
        var updateMovie = movie
        updateMovie.isFavourite.toggle()
        
        
        guard let index = findIndex(of: updateMovie,
                                    filteredList: filteredMoviesList,
                                    moviesList: moviesList,
                                    isSearching: isSearching) else {
            return
        }
        
        
        if isSearching {update(fileterArray: filteredMoviesList,
                   movieList: moviesList,
                   movie: updateMovie,
                   atIndex: index)
        } else {
            update(fileterArray: moviesList,
                   movieList: filteredMoviesList,
                   movie: updateMovie,
                   atIndex: index)
        }
    }
    
    /// This method will update `first` and `second` pass array with newly updated `movie` obect copy at `index` position
    /// - Parameters:
    ///   - fileterArray: This will be first array based on if user `isSearching` or not
    ///   - movieList: This will be second array based on if user `isSearching` or not
    ///   - movie: This will be update copy of our movie object
    ///   - atIndex: This will be `index` in which we have to replace object from `first` array
    func update(fileterArray: [MovieListModel], movieList: [MovieListModel], movie: MovieListModel, atIndex: Int) {
        self.filteredMoviesList[atIndex] = movie
        if let movieListIndex = moviesList.firstIndex(where: { $0 == movie }) {
            self.moviesList[movieListIndex] = movie
        }
    }
    
    func upadateDataStorage(isFav: Bool, movieID: String) {
        if isFav {
            DataStorageManager.shared.removeFromList(movieID)
        } else {
            DataStorageManager.shared.addToList(movieID)
        }
    }
    
    func findIndex(of movie: MovieListModel, filteredList: [MovieListModel], moviesList: [MovieListModel], isSearching: Bool) -> Int? {
        guard let index = (isSearching ? filteredMoviesList : moviesList)
            .firstIndex(where: { $0 == movie }) else {
            return nil
        }
        
        return index
    }
}
