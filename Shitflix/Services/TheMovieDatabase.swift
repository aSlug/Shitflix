//
//  TheMovieDatabase.swift
//  Shitflix
//
//  Created by BCamp User on 02/08/2019.
//  Copyright © 2019 BCamp User. All rights reserved.
//

import UIKit

class TheMovieDatabase {
    
    private static let apiKey = "695a476fc4109fe2d2f1d9d128a053e5"
    private static let apiEndpoint = "https://api.themoviedb.org/3/"
    private static let baseImgUrl = "http://image.tmdb.org/t/p/"
    
    private static let movie = "movie/"
    private static let headlinerID = 616
    
    enum PosterSizes: String {
        case w92, w154, w185, w342, w500, w780, original
    }
    
    enum BackdropSizes: String {
        case w300, w780, w1280, original
    }
    
    static func fetchImage(from path: String, ofSize size: PosterSizes, then handler: @escaping (Result<UIImage, Error>) -> Void) {
        
        let url = baseImgUrl + size.rawValue + "/" + path
        
        URLSession.shared.dataTask(with: URL(fileURLWithPath: url)) { data, response, error in
            
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    handler(.failure(error!)) //FIXME: does error always exists?
                    return
                }
            
            DispatchQueue.main.async() {
                handler(.success(image))
            }
            
        }.resume()
    }
    
    static func getMovie(id: Int, then handler: @escaping (Result<Movie, Error>) -> Void) {
        
        let url = apiEndpoint + movie + String(id) + "?api_key=" + apiKey
        
        URLSession.shared.dataTask(with: URL(fileURLWithPath: url)) { data, response, error in
            
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil
                else {
                    handler(.failure(error!)) //FIXME: does error always exists?
                    return
            }
            
            DispatchQueue.main.async() {
                let movie: Movie
                //TODO: use decoder to decode data to movie
                handler(.success(movie))
            }
            
        }.resume()
        
    }
    
}

