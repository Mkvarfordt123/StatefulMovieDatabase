//
//  MovieTableViewCell.swift
//  StatefulMovieDatabase
//
//  Created by Karl Pfister on 2/9/22.
//

import UIKit

@available(iOS 16.0, *)
class MovieTableViewCell: UITableViewCell {
    // MARK: - Outlets
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieSynopsisLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
   // MARK: - Properties

    
    func updateView(movie: Movie) {
    fetchImage(movie: movie)
    }
    func fetchImage(movie: Movie) {
        NetworkingController().fetchImage(with: movie.posterPath) { result in
            switch result {
            case .success(let poster):
                DispatchQueue.main.async {
                    self.movieImage.image = poster
                    self.movieTitleLabel.text = movie.title
                    self.movieSynopsisLabel.text = movie.synopsis
                }
            case .failure(let error):
                print(error.errorDescription!)
            }
        }
    }
}
// MARK: - Functions

