//
//  TheMovieDatabase.swift
//  Shitflix
//
//  Created by BCamp User on 02/08/2019.
//  Copyright © 2019 BCamp User. All rights reserved.
//

import UIKit

class TMDService {
    
    private static let apiKey = "695a476fc4109fe2d2f1d9d128a053e5"

    enum PosterSizes: String {
        case w92, w154, w185, w342, w500, w780, original
    }
    
    enum BackdropSizes: String {
        case w300, w780, w1280, original
    }
    
    static func fetchImage(from path: String, ofSize size: PosterSizes, then handler: @escaping (Result<UIImage, Error>) -> Void) {
        
        let url = TMDEndpoints.baseImgUrl + size.rawValue + "/" + path
        
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
        
        var urlComp = URLComponents(string: TMDEndpoints.apiEndpoint + TMDResources.movie + String(id))!
        urlComp.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        URLSession.shared.dataTask(with: URL(fileURLWithPath: urlComp.url!.absoluteString)) { data, response, error in
            
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil
                else {
                    handler(.failure(error!)) //FIXME: does error always exists?
                    return
            }
            
            DispatchQueue.main.async() {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                do {
                    let movie = try decoder.decode(Movie.self, from: data)
                    handler(.success(movie))
                } catch {
                    handler(.failure(error))
                }
            }
            
        }.resume()
        
    }
    
    static func getMovieStrip(for type: MovieGroupType, then handler: @escaping (Result<[Movie], Error>) -> Void) {
        
        /* internal structure used to decode an array of movies */
        struct Page: Codable {
            let results: [Movie]
        }
        
        let resource: String
        switch type {
        case .popular:
            resource = TMDResources.popular
        case .upcoming:
            resource = TMDResources.upcoming
        case .latest:
            resource = TMDResources.latest
        case .topRated:
            resource = TMDResources.topRated
        }
        
        var urlComp = URLComponents(string: TMDEndpoints.apiEndpoint + resource)!
        urlComp.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        URLSession.shared.dataTask(with: URL(fileURLWithPath: urlComp.url!.absoluteString)) { data, response, error in
            
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil
                else {
                    handler(.failure(error!)) //FIXME: does error always exists?
                    return
            }
            
            DispatchQueue.main.async() {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                do {
                    let page = try decoder.decode(Page.self, from: data)
                    handler(.success(page.results))
                } catch {
                    handler(.failure(error))
                }
            }
            
        }.resume()
        
    }
    
}

