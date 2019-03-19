import UIKit
import SnapKit
import RxCocoa
import RxSwift
class ViewController: UIViewController, UICollectionViewDataSource {
    
    let movies: Variable<[Movie]> = Variable([])
    let padding:CGFloat = 16
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    let layout = UICollectionViewFlowLayout()
    let bag = DisposeBag()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.value.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.cellId, for: indexPath) as! MovieCell
        cell.movie = movies.value[indexPath.row]
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        
        collectionView.backgroundColor = #colorLiteral(red: 0.04572060704, green: 0.07732533664, blue: 0.1312836409, alpha: 1)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.cellId)
        collectionView.fillSuperView(superView: view)
        
        movies.asObservable()
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { [weak self] _ in
            self?.collectionView.reloadData()
        })
        .disposed(by: bag)
        
        let fetchedMovies = Service.movies
        
        fetchedMovies
            .bind(to: movies)
            .disposed(by: bag)

    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 2 * padding  , height: 140 )
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
     let detailVC = DetailViewController(movie: movies.value[indexPath.row])
        
        present(detailVC, animated: true)
    }
}
