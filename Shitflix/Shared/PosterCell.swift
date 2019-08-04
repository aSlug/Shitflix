import UIKit

class PosterCell: UICollectionViewCell {
    
    static let rID = "poster"
    
    var movie: Movie? {
        didSet {
            update()
        }
    }
    
    var didSelectMovie: ((Movie) -> ())?
    
    private var poster = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
        style()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.contentView.addSubview(poster)
        poster.addTarget(self, action: #selector(onTap), for: .touchUpInside)
    }
    
    private func style() {
        self.clipsToBounds = true
    }
    
    private func update() {
        guard movie != nil else { return }
        
        TMDService.fetchImage(from: self.movie!.posterPath, ofSize: .w342) { result in
            switch result {
            case .success(let image):
                self.poster.setBackgroundImage(image, for: .normal)
            case .failure(let error):
                print("Failure while retrieving image for movie \(self.movie!.title) from url \(self.movie!.posterPath)")
                print(error)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        poster.frame = CGRect(
            x: 0,
            y: 0,
            width: self.bounds.width,
            height: self.bounds.height
        )
    }
    
    @objc func onTap() {
        print("Tap on poster of movie \(self.movie?.title ?? "unknown")")
        guard let movie = self.movie else { return }
        self.didSelectMovie?(movie)
    }
    
}
