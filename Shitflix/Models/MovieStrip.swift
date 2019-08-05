import Foundation

struct MovieStrip {
    
    let type: MovieStripType
    var movies: [Movie]?
    
}

enum MovieStripType: String, CaseIterable {
    case upcoming = "In arrivo"
    case popular = "Popolari ora"
    case topRated = "Top rated"
}
