//
//  MovieListViewController.swift
//  WisdomleafMovieApp
//
//  Created by Ankur Kumar on 30/08/24.
//

import UIKit

protocol MovieListCollectionViewCellDelegate: AnyObject {
    func didTapFavoriteButton(on cell: MovieListCollectionViewCell, movie: MovieListModel)
}


final class MovieListViewController: UIViewController {
    
    @IBOutlet weak var collectionView:UICollectionView!
    
    var moviesList: [MovieListModel] = []
    var filteredMoviesList: [MovieListModel] = []
    var isSearching = false
    
    private var apiClient = MovieListApiClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewSetup()
        collectionView.dataSource = self
        collectionView.delegate = self
        configurationCollectioViewCell()
        fetchMovieList()
        filteredMoviesList = moviesList
        searchBarController()
    }
    
    /// MARK: - API LOGIC
    func fetchMovieList() {
        apiClient.fetchMovieList { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let movies):
                self.setup(movies: movies, storage: .shared)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func setup(movies: [MovieListModel], storage: DataStorageManager) {
        self.filteredMoviesList = movies
        
        for movie in movies {
            var movieItem = movie
            let isFav = storage.isAddedToList(movieItem.imdbID)
            
            movieItem.update(favourite: isFav)
            self.moviesList.append(movieItem)
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func collectionViewSetup(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
    }
    
    func configurationCollectioViewCell() {
        collectionView.register(UINib(nibName: Constant.MovieListCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Constant.MovieListCollectionViewCell)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "identifier")
    }
    
    func searchBarController(){
        let searchControl = UISearchController(searchResultsController: nil)
        searchControl.searchResultsUpdater = self
        searchControl.obscuresBackgroundDuringPresentation = false
//        searchControl.searchBar.placeholder = "Search Movies"
        searchControl.searchBar.delegate = self
        self.navigationItem.searchController = searchControl
        self.definesPresentationContext = true
    }
}

