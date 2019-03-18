import UIKit

class ViewController: UIViewController,
UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    let cellId = "cellId"
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    let layout = UICollectionViewFlowLayout()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .yellow
        
        print(cell)
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
}

