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
        
        /* retrieve strips */
        for movieGroupType: MovieStripType in [
            .upcoming,
            .popular,
            .topRated
            ] {
            
            TMDService.getMovieStrip(for: movieGroupType, then: { result in
                switch result {
                case .success(let movies):
                    let strip = MovieStrip(type: movieGroupType, movies: movies)
                    self.strips.append(strip)
                case .failure(let error):
                    print("Failure while retrieving movies for strip \(movieGroupType.rawValue)")
                    print(error)
                }
            })
            
        }
        
    }
    
}
