//
//  ViewController.swift
//  Diagnal
//
//  Created by Avinash Thakur on 01/07/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var fetchMovieButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    /// IBAction to handle fetch movie button tap action.
    @IBAction func fetchMoviesButtonTapped(_ sender: UIButton) {
        loadMoviesView()
    }
    
    /// Function loads MovieListViewController
    private func loadMoviesView() {
        guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MovieListViewController") as? MovieListViewController else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

