//
//  MovieListTableViewController.swift
//  StatefulMovieDatabase
//
//  Created by Karl Pfister on 2/9/22.
//

import UIKit

@available(iOS 16.0, *)
class MovieListTableViewController: UITableViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var tld: topLevelDict?
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tld?.movies.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        //TODO: - Finish the Cell Set up
        guard let movie = tld?.movies[indexPath.row] else { return UITableViewCell()}
        cell.updateView(movie: movie)
        return cell
    }
    
}

@available(iOS 16.0, *)
extension MovieListTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        NetworkingController().fetch(endpoint: "movie", with: searchTerm) { result in
            switch result {
            case .success(let tld):
                DispatchQueue.main.async {
                    self.tld = tld
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.errorDescription!)
            }
        }
        searchBar.resignFirstResponder()
    }
    //TODO: - Search for a Movie
}

