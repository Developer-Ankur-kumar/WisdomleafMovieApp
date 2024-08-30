//
//  SearchBarDelegate.swift
//  WisdomleafMovieApp
//
//  Created by Ankur Kumar on 30/08/24.
//

import Foundation
import UIKit


extension MovieListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            filteredMoviesList = moviesList
            collectionView.reloadData()
            return
        }
        
        filteredMoviesList = moviesList.filter { movie in
            return movie.title.lowercased().contains(searchText.lowercased())
        }
        collectionView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
    }
}
