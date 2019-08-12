import Foundation

class MovieArchive {
    
    // singleton instance of the whole movie archive
    static let archive = MovieArchive()
    
    var headliner: Movie? {
        didSet {
            archiveDidUpdate()
        }
    }
    
    var strips: [MovieStrip] = [] {
        didSet {
            archiveDidUpdate()
        }
    }
    
    var archiveDidUpdate: () -> Void = {
        print("archiveDidUpdate not defined yet")
    }
    
    init() {
        
        /* retrieve headliner */
        TMDService.getMovie(id: Constants.headlinerID, then: { result in
            switch result {
            case .success(let movie):
                self.headliner = movie
            case .failure(let error):
                print("Failure while retrieving movie with id \(Constants.headlinerID)")
                print(error)
            }
        })
        
        /* retrieve upcoming movies */
        TMDService.getMovieList(of: .upcoming, then: { result in
            switch result {
            case .success(let movies):
                let strip = MovieStrip(type: .upcoming, movies: movies)
                self.strips.append(strip)
            case .failure(let error):
                print("Failure while retrieving movies for strip \(MovieStripType.upcoming.rawValue)")
                print(error)
            }
        })
        
        /* retrieve this year's movies */
        TMDService.getMovies(ofYear: 2019, then: { result in
            switch result {
            case .success(let movies):
                let strip = MovieStrip(type: .thisYear, movies: movies)
                self.strips.append(strip)
            case .failure(let error):
                print("Failure while retrieving movies for strip \(MovieStripType.thisYear.rawValue)")
                print(error)
            }
        })
        
        /* retrieve list of movies by genre */
        for g in [
            TMDGenres.fantasy,
            TMDGenres.action,
            TMDGenres.comedy
            ] {
             
                TMDService.getMovies(withGenre: g.id, then: { result in
                    switch result {
                    case .success(let movies):
                        let strip = MovieStrip(type: .genre, movies: movies)
                        self.strips.append(strip)
                    case .failure(let error):
                        print("Failure while retrieving movies for strip \(g.name)")
                        print(error)
                    }
                })
                
        }
        
    }
    
}
