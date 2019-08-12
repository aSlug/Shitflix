import UIKit

class TMDService {
    
    private static let apiKey = "695a476fc4109fe2d2f1d9d128a053e5"

    enum PosterSizes: String {
        case w92, w154, w185, w342, w500, w780, original
    }
    
    enum BackdropSizes: String {
        case w300, w780, w1280, original
    }
    
    enum MovieListType {
        case popular
        case upcoming
        case topRated
    }
    
    /* internal structure used to decode an array of movies */
    private struct Page: Codable {
        let results: [Movie]
    }
    
    private static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }
    
    static func fetchImage(from path: String, ofSize size: PosterSizes, then handler: @escaping (Result<UIImage, Error>) -> Void) {
        
        let url = TMDEndpoints.baseImgUrl + size.rawValue + path
        
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            
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
        
        let resource = TMDResources.movie.replacingOccurrences(of: "{movie_id}", with: String(id))
        var urlComp = URLComponents(string: TMDEndpoints.apiEndpoint + resource)!
        urlComp.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        let url = urlComp.url!.absoluteString
        
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil
                else {
                    handler(.failure(error!)) //FIXME: does error always exists?
                    return
            }
            
            DispatchQueue.main.async() {
                do {
                    let movie = try decoder.decode(Movie.self, from: data)
                    handler(.success(movie))
                } catch {
                    handler(.failure(error))
                }
            }
            
        }.resume()
        
    }
    
    static func getMovieList(of listType: MovieListType, then handler: @escaping (Result<[Movie], Error>) -> Void) {

        let resource: String
        
        switch listType {
        case .popular:
            resource = TMDResources.popular
        case .topRated:
            resource = TMDResources.topRated
        case .upcoming:
            resource = TMDResources.upcoming
        }
        
        var urlComp = URLComponents(string: TMDEndpoints.apiEndpoint + resource)!
        urlComp.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        let url = urlComp.url!.absoluteString
        
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil
                else {
                    handler(.failure(error!)) //FIXME: does error always exists?
                    return
            }
            
            DispatchQueue.main.async() {
                do {
                    let page = try decoder.decode(Page.self, from: data)
                    let cleanResult = page.results.filter { !$0.posterPath.isEmpty }
                    handler(.success(cleanResult))
                } catch {
                    handler(.failure(error))
                }
            }
            
        }.resume()
        
    }
    
    static func getReccomendations(for movieId: Int, then handler: @escaping (Result<[Movie], Error>) -> Void) {
        
        let resource = TMDResources.reccomendations.replacingOccurrences(of: "{movie_id}", with: String(movieId))
        var urlComp = URLComponents(string: TMDEndpoints.apiEndpoint + resource)!
        urlComp.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        let url = urlComp.url!.absoluteString
        
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil
                else {
                    handler(.failure(error!)) //FIXME: does error always exists?
                    return
            }
            
            DispatchQueue.main.async() {
                do {
                    let page = try decoder.decode(Page.self, from: data)
                    let cleanResult = page.results.filter { !$0.posterPath.isEmpty }
                    handler(.success(cleanResult))
                } catch {
                    handler(.failure(error))
                }
            }
            
            }.resume()
        
    }
    
    static func searchMovie(with query: String, then handler: @escaping (Result<[Movie], Error>) -> Void) {
        
        let resource = TMDResources.searchMovie
        var urlComp = URLComponents(string: TMDEndpoints.apiEndpoint + resource)!
        urlComp.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "query", value: query)
        ]
        let url = urlComp.url!.absoluteString
        
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil
                else {
                    handler(.failure(error!)) //FIXME: does error always exists?
                    return
            }
            
            DispatchQueue.main.async() {
                do {
                    let page = try decoder.decode(Page.self, from: data)
                    let cleanResult = page.results.filter { !$0.posterPath.isEmpty }
                    handler(.success(cleanResult))
                } catch {
                    handler(.failure(error))
                }
            }
            
            }.resume()
        
    }
    
    static func getMovies(withGenre genre: Int, then handler: @escaping (Result<[Movie], Error>) -> Void) {
        
        let resource = TMDResources.discoverMovie
        var urlComp = URLComponents(string: TMDEndpoints.apiEndpoint + resource)!
        urlComp.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "vote_count.gte", value: "10"),
            URLQueryItem(name: "vote_average.lte", value: "5"),
            URLQueryItem(name: "with_genres", value: String(genre))
        ]
        let url = urlComp.url!.absoluteString
        
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil
                else {
                    handler(.failure(error!)) //FIXME: does error always exists?
                    return
            }
            
            DispatchQueue.main.async() {
                do {
                    let page = try decoder.decode(Page.self, from: data)
                    let cleanResult = page.results.filter { !$0.posterPath.isEmpty }
                    handler(.success(cleanResult))
                } catch {
                    handler(.failure(error))
                }
            }
            
            }.resume()
        
    }
    
    static func getMovies(ofYear year: Int, then handler: @escaping (Result<[Movie], Error>) -> Void) {
        
        let resource = TMDResources.discoverMovie
        var urlComp = URLComponents(string: TMDEndpoints.apiEndpoint + resource)!
        urlComp.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "vote_count.gte", value: "10"),
            URLQueryItem(name: "vote_average.lte", value: "5"),
            URLQueryItem(name: "year", value: String(year))
        ]
        let url = urlComp.url!.absoluteString
        
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil
                else {
                    handler(.failure(error!)) //FIXME: does error always exists?
                    return
            }
            
            DispatchQueue.main.async() {
                do {
                    let page = try decoder.decode(Page.self, from: data)
                    let cleanResult = page.results.filter { !$0.posterPath.isEmpty }
                    handler(.success(cleanResult))
                } catch {
                    handler(.failure(error))
                }
            }
            
            }.resume()
        
    }
    
}

