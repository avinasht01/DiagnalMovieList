//
//  MovieListViewController.swift
//  Diagnal
//
//  Created by Avinash Thakur on 01/07/23.
//

import UIKit

class MovieListViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var backButtonImage: UIImageView!
    @IBOutlet weak var searchButtonImage: UIImageView!
    
    var screenWidth: CGFloat!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    var activityIndicatorView: UIActivityIndicatorView!
    
    var viewModel: MovieViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        screenWidth = UIScreen.main.bounds.width
        initialiseCollectionView()
        addActivityIndicator()
        initialiseSearchBarUI()
        addRequiredGestures()
        fetchMovies()
    }
    
    /// Function initialises the search bar ui and sets it delegate
    func initialiseSearchBarUI() {
        searchBar.isHidden = true
        searchBar.delegate = self
        self.definesPresentationContext = false
        searchBar.tintColor = UIColor.white
        searchBar.backgroundColor = UIColor.black
        searchBar.barTintColor = UIColor.white
        let searchBarTextField = searchBar.value(forKey: "searchField") as? UITextField
        searchBarTextField?.textColor = UIColor.white
        searchBar.searchBarStyle = .minimal
        searchBar.returnKeyType = .search
        searchBar.showsCancelButton = true
        searchBar.showsBookmarkButton = false
        searchBar.sizeToFit()
    }
    
    /// Function adds tap gesture to handle back button, search button tap and to dismiss keyboard.
    func addRequiredGestures() {
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.handleBackButtonTap(_:)))
        tap1.delegate = self
        backButtonImage.addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.handleSearchButtonTap(_:)))
        tap2.delegate = self
        searchButtonImage.addGestureRecognizer(tap2)
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        tap3.delegate = self
        self.view.addGestureRecognizer(tap3)
    }
    
    @objc func handleBackButtonTap(_ sender: UITapGestureRecognizer? = nil) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSearchButtonTap(_ sender: UITapGestureRecognizer? = nil) {
        searchBar.isHidden = false
        self.searchButtonImage.isHidden = true
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer? = nil) {
        self.view.endEditing(true)
    }
    
    // MARK: - Activity Indicator Functions
    
    /// Functions adds activity indicator on view.
    private func addActivityIndicator() {
        activityIndicatorView = UIActivityIndicatorView(style: .white)
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.center = self.view.center
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.isHidden = true
    }
    
    /// Functions starts animating the activity indicator
    private func startAnimating() {
        DispatchQueue.main.async {
            self.activityIndicatorView.isHidden = false
            self.activityIndicatorView.startAnimating()
        }
    }
    
    /// Functions stops animating the activity indicator
    private func stopAnimating() {
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    /// Functions initialises collection view by registering nib file and assigns the delegates
    private func initialiseCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = createCollectionViewFlowLayout()
        let xib = UINib(nibName: "MovieCollectionViewCell", bundle: .main)
        collectionView.register(xib, forCellWithReuseIdentifier: "MovieCollectionViewCell")
    }
    
    /// Functions creates collection flow layout to display movie cell items.
    private func createCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let width = (screenWidth / Constants.itemCount)
        layout.itemSize = CGSize(width: width, height: Constants.itemHeight)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return layout
    }
    
    /// Functions initialises movie view model and fetches the movie content.
    private func fetchMovies() {
        viewModel = MovieViewModel()
        viewModel.delegate = self
        viewModel.fetchMoviesData()
    }
    
    /// Function displays alerts for  ailure while fetching movie details.
    func showFailureAlert() {
        let alert = UIAlertController(title: "Failure", message: "Failed to load movies", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Okay", style: .default, handler: { action in
        }))
        self.present(alert, animated: false)
    }
    
}

// MARK: - Collection view delegate Functions
extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.filteredMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setCellUI(movie: viewModel.filteredMovies[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (screenWidth / Constants.itemCount)
        return CGSize(width: width, height: Constants.itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.checkAndFetchNextMovieList(index: indexPath.item)
    }
    
}

// MARK: - MovieViewModelDelegate Functions
extension MovieListViewController: MovieViewModelDelegate {
    func didStartedFetchingList() {
        DispatchQueue.main.async {
            self.startAnimating()
        }
    }
    
    func didReceiveMovieList() {
        DispatchQueue.main.async {
            self.stopAnimating()
            self.collectionView.reloadData()
        }
    }
    
    func didFailedWithError() {
        DispatchQueue.main.async {
            self.showFailureAlert()
        }
    }
    
}

extension MovieListViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
        self.collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.text = ""
        self.viewModel.filteredMovies = self.viewModel.movieList
        self.searchBar.showsCancelButton = false
        self.searchBar.endEditing(true)
        self.collectionView.reloadData()
        self.searchButtonImage.isHidden = false
        self.searchBar.isHidden = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text! != "" {
            viewModel.filteredMovies = viewModel.movieList.filter({ movie in
                return (movie.name.localizedCaseInsensitiveContains(String(searchBar.text!)))
            })
        } else {
            viewModel.filteredMovies = viewModel.movieList
        }
        collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        collectionView.reloadData()
        self.view.endEditing(true)
    }
    
}
