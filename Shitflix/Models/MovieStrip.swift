import Foundation

struct MovieStrip {
    
    let type: MovieStripType
    var movies: [Movie]?
    
}

/*
 NOTE: the order of the enums determines the
 order the sprips are enlisted
 */
enum MovieStripType: String, CaseIterable {
    case upcoming = "In arrivo"
    case latest = "Nuove uscite"
    case popular = "Popolari ora"
    case topRated = "Top rated"
}
