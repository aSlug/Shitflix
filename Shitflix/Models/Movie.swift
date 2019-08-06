import UIKit

struct Movie {
    
    /* info from movie lists */
    let posterPath: String
    let overview: String?
    let releaseDate: Date?
    let genre: [Int]
    let id: Int
    let originalTitle: String?
    let title: String
    let backdropPath: String?
    let popularity: Double?
    let votes: Int?
    let voteAvg: Double?
    
    /* extra info from movie details */
    let tagline: String?
    let runtime: Int?
    let budget: Int?
    let revenue: Int?
    let homepage: String?
}

extension Movie: Codable {
    
    enum Codingkeys: String, CodingKey {
        case poster = "poster_path"
        case overview = "overview"
        case releaseDate = "release_date"
        case genre = "genre_ids"
        case id = "id"
        case originalTitle = "original_title"
        case title = "title"
        case backdrop = "backdrop_path"
        case popularity = "popularity"
        case votes = "vote_count"
        case voteAvg = "vote_average"
        case tagline = "tagline"
        case runtime = "runtime"
        case buget = "budget"
        case revenue = "revenue"
        case homepage = "homepage"
    }
    
    /* decoding must fail if id, title or poster is not present */
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Codingkeys.self)
        
        posterPath = (try? values.decodeIfPresent(String.self, forKey: .poster)) ?? ""
        releaseDate = try? values.decodeIfPresent(Date.self, forKey: .releaseDate)
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
        genre = try values.decodeIfPresent([Int].self, forKey: .genre) ?? []
        id = try values.decode(Int.self, forKey: .id)
        originalTitle = try values.decodeIfPresent(String.self, forKey: .originalTitle)
        title = try values.decode(String.self, forKey: .title)
        backdropPath = try values.decodeIfPresent(String.self, forKey: .backdrop)
        popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
        votes = try values.decodeIfPresent(Int.self, forKey: .votes)
        voteAvg = try values.decodeIfPresent(Double.self, forKey: .voteAvg)
        tagline = try values.decodeIfPresent(String.self, forKey: .tagline)
        runtime = try values.decodeIfPresent(Int.self, forKey: .runtime)
        budget = try values.decodeIfPresent(Int.self, forKey: .buget)
        revenue = try values.decodeIfPresent(Int.self, forKey: .revenue)
        homepage = try values.decodeIfPresent(String.self, forKey: .homepage)
    }
    
}
