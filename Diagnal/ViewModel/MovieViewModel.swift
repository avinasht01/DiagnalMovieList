//
//  MovieViewModel.swift
//  Diagnal
//
//  Created by Avinash Thakur on 01/07/23.
//

import Foundation

struct Constants {
    static let resourceFileName = "CONTENTLISTINGPAGE-PAGE"
    static let itemCount = 3.0
    static let itemHeight = 320.0
}


protocol MovieViewModelDelegate: NSObjectProtocol {
    /// Delegate function to notify view controller to reload content
    func didReceiveMovieList()
    /// Delegate function to notify view controller to show activity indicator
    func didStartedFetchingList()
    /// Delegate function to notify view controller if there is any error while fetching movie list
    func didFailedWithError()
}

class MovieViewModel {
    var currentPage = 1
    var movieList: [Movie] = []
    
    var filteredMovies: [Movie] = []
    weak var delegate: MovieViewModelDelegate?
    
    /// Function fetches the movie page details for given current json page count. On successful fetching of page details, the movie list is updated with movies and view controller is notified to reload collection view.
    func fetchMoviesData() {
        self.delegate?.didStartedFetchingList()
        guard let movieResponse = Utitity.loadJson(fileName: Constants.resourceFileName + "\(currentPage)") else {
            self.delegate?.didFailedWithError()
            return
        }
        movieList.append(contentsOf: movieResponse.page.contentItems.content)
        filteredMovies = movieList
            self.delegate?.didReceiveMovieList()
    }
    
    /**
     Function checks for the current index of collection view item which will be displayed and checks if it is the 3rd last item of displayed items and fetches the next movie page details to update the movie list.It fethes only for 3 iterations of page detail as there are only 3 json resources
     - Parameter index: Int  Collection view item index
     */
    func checkAndFetchNextMovieList(index: Int) {
        if index == (movieList.count - 3) {
            currentPage = currentPage + 1
            if currentPage < 4 {
                fetchMoviesData()
            }
        }
    }
    
}
