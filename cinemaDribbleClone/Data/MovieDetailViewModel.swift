import Foundation
import UIKit
import RxSwift
import RxCocoa
class MovieDetailViewModel{
    let movie: Variable<Movie>
    let bag = DisposeBag()
    
    var movieTitle: Observable<String> {
        return movie.asObservable().map { $0.title }
    }
    var infoText: Observable<String> {
        return movie.asObservable().map { String($0.year) + " Valerie Farries" }
    }
    var rating: Observable<Double> {
        return movie.asObservable().map { $0.rating }
    }
    
    var imgUrl: Observable<String?> {
        return movie.asObservable().map { $0.imageUrl }
    }
    
    
    
    init(mv: Movie) {
        movie = Variable(mv)
    }
}

