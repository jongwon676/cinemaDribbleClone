import UIKit
import SnapKit
import Cosmos

class MovieCell: UICollectionViewCell{
    static let cellId = "MovieCell"
    
    
    lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.image = #imageLiteral(resourceName: "aabc")
        return imageView
    }()
    
    lazy var starView: CosmosView = {
       let starView = CosmosView(frame: .zero)
        starView.settings.filledColor = .red
        starView.settings.emptyBorderColor = .red
        starView.settings.filledBorderColor = .red
        starView.rating = 4
        starView.settings.updateOnTouch = false
        starView.settings.starSize = 15
        
        return starView
    }()
    
    let movieNameLabel = UILabel(font: UIFont.systemFont(ofSize: 18,weight: .medium), textColor: #colorLiteral(red: 0.6034280658, green: 0.7129382491, blue: 0.9536679387, alpha: 1))
    let descriptionLabel = UILabel(font:  UIFont.systemFont(ofSize: 12), textColor: #colorLiteral(red: 0.2941176471, green: 0.3624315858, blue: 0.4828500152, alpha: 1), numberOfLines: 2)
    let durationLabel = UILabel(font: UIFont.systemFont(ofSize: 12), textColor: #colorLiteral(red: 0.2941176471, green: 0.3624315858, blue: 0.4828500152, alpha: 1))
    let ratingLabel = UILabel(font: UIFont.systemFont(ofSize: 25, weight: .medium), textColor: #colorLiteral(red: 0.939080596, green: 0.7023364902, blue: 0.09189794213, alpha: 1))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.1399548352, green: 0.1713743508, blue: 0.2336535454, alpha: 1)
        let vStackView = UIStackView(arrangedSubviews: [movieNameLabel,descriptionLabel,starView,durationLabel,UIView()], spacing: 5)
        
        vStackView.axis = .vertical
        vStackView.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        vStackView.isLayoutMarginsRelativeArrangement = true
        let hStackView = UIStackView(arrangedSubviews: [movieImageView, vStackView], spacing: 10)
        movieImageView.constraintWidth(90)
        hStackView.fillSuperView(superView: self, padding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        movieNameLabel.text = "Fright Night"
        descriptionLabel.text = "Actor: Jeremy Piven, Bridget Moynahan Director: Peter Chelsom"
        durationLabel.text =  "1 h 56min"
        ratingLabel.text = "8.5"
        
        
        self.addSubview(ratingLabel)
        
        ratingLabel.snp.makeConstraints { (mk) in
            mk.bottom.equalTo(hStackView.snp.bottom)
            mk.right.equalTo(hStackView.snp.right)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
