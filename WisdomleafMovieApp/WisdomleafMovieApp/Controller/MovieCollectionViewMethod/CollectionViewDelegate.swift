//
//  CollectionViewDelegate.swift
//  WisdomleafMovieApp
//
//  Created by Ankur Kumar on 30/08/24.
//

import Foundation
import UIKit


extension MovieListViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dataPassingController = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController else {
            return
        }
        
        let selectedMovie = isSearching ? filteredMoviesList[indexPath.row] : moviesList[indexPath.row]
        dataPassingController.selectedMovieID = selectedMovie.imdbID
        self.navigationController?.pushViewController(dataPassingController, animated: true)
    }
}
