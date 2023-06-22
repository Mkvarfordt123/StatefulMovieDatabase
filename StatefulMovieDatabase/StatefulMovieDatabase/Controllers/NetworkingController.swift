//
//  NetworkingController.swift
//  StatefulMovieDatabase
//
//  Created by Milo Kvarfordt on 6/22/23.
//

import Foundation
import UIKit.UIImage

@available(iOS 16.0, *)
struct NetworkingController {
    // url
// https://api.themoviedb.org/3/search/movie?api_key=e995caa0834dcff7529a9a456fb8d0e2&query=The Mummy    //data task
    
    //decode the data
    
    func fetch(endpoint: String, with searchTerm: String, completion: @escaping (Result<topLevelDict, ResultError>) -> Void) {
        
        guard let baseURL = URL(string: "https://api.themoviedb.org/3/search") else {completion(.failure(.invalidURL)); return }
        
        var urlRequest = URLRequest(url: baseURL)
        
        urlRequest.url?.append(path: endpoint)
        let apiKeyQueryItem = URLQueryItem(name: "api_key", value: "e995caa0834dcff7529a9a456fb8d0e2")
        let searchQueryItem = URLQueryItem(name: "query", value: searchTerm)
        urlRequest.url?.append(queryItems: [apiKeyQueryItem, searchQueryItem])
        print(urlRequest.url)
        
        URLSession.shared.dataTask(with: urlRequest) { movieData, movieResponse, error in
            if let error {
                completion(.failure(.thrownError(error))); return
            }
            if movieResponse == nil {
                completion(.failure(.movieResponse)); return
            }
            guard let movieData else {completion(.failure(.noData)); return}
            do{
                let topLevelDictionary = try JSONDecoder().decode(topLevelDict.self, from: movieData)
                completion(.success(topLevelDictionary))
            } catch {
                completion(.failure(.unableToDecode)); return
            }
        }.resume()
    }
     func fetchImage(with posterPath: String, completion: @escaping (Result<UIImage, ResultError>) -> Void) {
        //create url
        guard let baseURL = URL(string: "https://image.tmdb.org/t/p/w500") else { return }
       
        var urlRequest = URLRequest(url: baseURL)
        
        urlRequest.url?.append(path: posterPath)
         
        URLSession.shared.dataTask(with: urlRequest) { imageData, _, error in
            if let error = error {
                print("There was an error", error.localizedDescription)
                completion(.failure(.invalidURL)); return
            }
            guard let imageData else {completion(.failure(.noData)); return}
            
            guard let moviePoster = UIImage(data: imageData) else {completion(.failure(.unableToDecode)); return }
            completion(.success(moviePoster))
        }.resume()
    }
}
