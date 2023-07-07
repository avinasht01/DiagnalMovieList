//
//  MovieCollectionViewCell.swift
//  Diagnal
//
//  Created by Avinash Thakur on 02/07/23.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /**
     Function sets the movie cell content with movie name and movie poster image, In case of no image, placeholder image is displayed
     - Parameter movie: Movie  Movie Struct
     */
    func setCellUI(movie: Movie) {
        movieImage.image = nil
        if let image = UIImage(named: "\(movie.posterImage)") {
            movieImage.image = image
        } else {
            movieImage.image = UIImage(named: "placeholder")
        }
        movieName.text = movie.name
    }

}
