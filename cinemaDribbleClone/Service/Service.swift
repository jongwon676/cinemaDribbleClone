import Foundation
import RxSwift
import RxCocoa
import UIKit
import Foundation

enum ServiceError: Error {
    
    case invalidURL(String)
    case invalidParameter(String, Any)
    case invalidJSON(String)
}

class Service{
    static let API = "https://yts.am/api/v2/list_movies.json"
    
    static func request<T:Codable>(query: [String: Any] = [:]) -> Observable<T>{
        do{
            guard let url = URL(string: API), var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
                else { throw ServiceError.invalidURL("") }
            components.queryItems = try query.compactMap { (key, value) in
                guard let v = value as? CustomStringConvertible else {
                    throw ServiceError.invalidParameter(key, value)
                }
                return URLQueryItem(name: key, value: v.description)
            }
            guard let finalURL = components.url else{
                throw ServiceError.invalidURL("")
            }
            let request = URLRequest(url: finalURL)
            return URLSession.shared.rx.response(request: request)
                .map { _, data in
                    let result = try JSONDecoder().decode(T.self, from: data)
                    return result
            }
        }catch{
            return Observable.empty()
        }        
    }
    
    static var movies: Observable<[Movie]> = {
        let reponse: Observable<MovieListResponse> = Service.request()
        return reponse.map { response in
            response.movies
        }
    }()
    
}
