import Foundation

struct MovieStrip {
    
    let type: MovieStripType
    var movies: [Movie]?
    
}

enum MovieStripType: String, CaseIterable {
    case upcoming = "Delusioni in arrivo"
    case thisYear = "Il peggio quest'anno"
    case genre = "Il peggio dei film"
}
