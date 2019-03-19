import UIKit
import Foundation

struct MovieListResponse: Codable{
    let movies: [Movie]
    enum DataCodkingKey: String,CodingKey{
        case data
    }
    enum MovieCodkingKey: String,CodingKey{
        case movies
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DataCodkingKey.self)
        let c = try container.nestedContainer(keyedBy: MovieCodkingKey.self, forKey: .data)
        movies = try c.decode([Movie].self, forKey: .movies)
    }
}


struct Movie: Codable{
    
    let id: Int
    let title: String
    let year: Int
    let runtime: Int
    let rating: Double
    let imageUrl: String?
    let description: String
    
    enum CodingKeys: String,CodingKey{
        case id, title, year, runtime, rating
        case imageUrl = "large_cover_image"
        case description = "summary"
    }
}
