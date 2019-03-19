import UIKit
import Cosmos
import SnapKit
import RxSwift

class DetailViewController: UIViewController{
    
    let viewModel: MovieDetailViewModel
    let bag = DisposeBag()
    let imageView = UIImageView()
    let exitButton = UIButton(type: .system)
    
    let movieNameLabel = UILabel(
        font: UIFont.systemFont(ofSize: 38,weight: .semibold),
        textColor: UIColor.black,
        numberOfLines: 0)
    
    let infoLabel = UILabel(
        font: UIFont.systemFont(ofSize: 16, weight: .medium),
        textColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
    
    lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "button-play").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .red
        button.constraintWidth(60)
        button.constraintHeight(60)
        return button
    }()
    
    lazy var starView: CosmosView = {
        let starView = CosmosView(frame: .zero)
        starView.settings.filledColor = .red
        starView.settings.emptyBorderColor = .red
        starView.settings.filledBorderColor = .red
        starView.settings.updateOnTouch = false
        starView.settings.starSize = 20
        return starView
    }()
    
    init(movie: Movie) {
        viewModel = MovieDetailViewModel(mv: movie)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func setupExitButton() {
        exitButton.setTitle("+", for: .normal)
        exitButton.tintColor = .black
        exitButton.titleLabel?.font = UIFont.systemFont(ofSize: 50 ,weight: .medium)
        exitButton.transform = CGAffineTransform.init(rotationAngle: CGFloat.pi / 4)
        view.addSubview(exitButton)
        exitButton.snp.makeConstraints { (mk) in
            mk.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            mk.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(10)
            mk.height.width.equalTo(50)
        }
        exitButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
    }
    
    @objc func handleDismiss(){
        self.presentingViewController?.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        setupMovieImageView()
        setVStackView()
        setupExitButton()
        
        movieNameLabel.textAlignment = .center
        
        
        
        
        
        viewModel.movieTitle.bind(to: movieNameLabel.rx.text).disposed(by: bag)
        viewModel.infoText.bind(to: infoLabel.rx.text).disposed(by: bag)
        viewModel.rating.subscribe(onNext: {
            self.starView.rating = $0
        }).disposed(by: bag)
        
        viewModel.imgUrl.subscribe(onNext: { imgUrl in
            let url = imgUrl.flatMap { URL(string:$0) }
            self.imageView.sd_setImage(with: url)
        }).disposed(by: bag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setTransparentGradientLayer()
    }
    
    func setVStackView(){
        let vStackView = UIStackView(arrangedSubviews: [movieNameLabel,infoLabel,starView,playButton], spacing: 5)
        vStackView.axis = .vertical
        vStackView.alignment = .center
        view.addSubview(vStackView)
        vStackView.snp.makeConstraints { (mk) in
//            mk.centerX.equalTo(view)
            mk.left.equalTo(view).offset(15)
            mk.right.equalTo(view).inset(15)
            mk.top.equalTo(imageView.snp.bottom).inset(50)
        }
    }
    
    func setTransparentGradientLayer(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = imageView.bounds
        gradientLayer.colors = [
            UIColor.white.withAlphaComponent(1).cgColor,
            UIColor.white.withAlphaComponent(0).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.70)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        imageView.layer.mask = gradientLayer
    }
    
    func setupMovieImageView(){
        imageView.image = #imageLiteral(resourceName: "aabc")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.fillSuperView(superView: view, padding: .init(top: 0, left: 0, bottom: 300, right: 0))
    }
    
}
