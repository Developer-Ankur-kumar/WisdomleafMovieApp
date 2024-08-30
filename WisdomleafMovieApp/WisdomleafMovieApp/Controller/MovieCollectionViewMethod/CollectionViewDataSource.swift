//
//  MovieListViewController.swift
//  WisdomleafMovieApp
//
//  Created by Ankur Kumar on 30/08/24.
//

import Foundation
import UIKit



extension MovieListViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isSearching ? filteredMoviesList.count : moviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCollectionViewCell", for: indexPath) as? MovieListCollectionViewCell else {
            return UICollectionViewCell(frame: .zero)
        }
        
        let movie = isSearching ? filteredMoviesList[indexPath.row] : moviesList[indexPath.row]
        cell.productDetailConfiguration(movie: movie)
        cell.delegate = self
        
        return cell
    }
}
