import UIKit

class HeadlineMovieCell: UICollectionViewCell {
    
    static let rID = "headliner"
    
    var movie: Movie? {
        didSet {
            update()
        }
    }
    
    var didAddToList: ((Movie) -> ())?
    var didPlay: ((Movie) -> ())?
    var didInfo: ((Int) -> ())?
    
    private var poster = UIImageView()
    private var addToListBtn = UIButton() // TODO: create custom button
    private var playBtn = UIButton() // TODO: create custom button
    private var infoBtn = UIButton()
    
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
        self.contentView.addSubview(addToListBtn)
        self.contentView.addSubview(playBtn)
        self.contentView.addSubview(infoBtn)
        
        addToListBtn.addTarget(self, action: #selector(onAddToList), for: .touchUpInside)
        playBtn.addTarget(self, action: #selector(onPlay), for: .touchUpInside)
        infoBtn.addTarget(self, action: #selector(onInfo), for: .touchUpInside)
    }
    
    private func style() {
        self.clipsToBounds = true
        
        addToListBtn.setImage(UIImage(named: "add-button-normal"), for: .normal)
        
        playBtn.setImage(UIImage(named: "play-button-black"), for: .normal)
        playBtn.setTitle("  Play", for: .normal)
        playBtn.setTitleColor(.black, for: .normal)
        playBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        playBtn.backgroundColor = .white
        
        infoBtn.setImage(UIImage(named: "info-icon-normal"), for: .normal)
    }
    
    private func update() {
        guard movie != nil else { return }
        
        TMDService.fetchImage(from: self.movie!.posterPath, ofSize: .w500) { result in
            switch result {
            case .success(let image):
                self.poster.image = image
            case .failure(let error):
                print("Failure while retrieving movie image from url \(self.movie!.posterPath)")
                print(error)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let w = self.bounds.width
        let h = self.bounds.height
        
        poster.frame = CGRect(
            x: 0,
            y: 0,
            width: w,
            height: h
        )
        poster.fadeView(style: .bottom, percentage: 0.15)
        addToListBtn.frame = CGRect(
            x: w * 0.10,
            y: h * 0.88,
            width: 30,
            height: 30
        )
        playBtn.frame = CGRect(
            x: w * 0.5 - 60,
            y: h * 0.88,
            width: 120,
            height: 35
        )
        playBtn.layer.cornerRadius = 3
        infoBtn.frame = CGRect(
            x: w * 0.90 - 30,
            y: h * 0.88,
            width: 30,
            height: 30
        )
    }
    
    @objc func onAddToList() {
        print("Click on add button")
        guard let movie = self.movie else {return}
        didAddToList?(movie)
    }
    @objc func onPlay() {
        print("Click on play button")
        guard let movie = self.movie else {return}
        didPlay?(movie)
    }
    @objc func onInfo() {
        print("Click on info button")
        guard let movie = self.movie else {return}
        didInfo?(movie.id)
    }
    
}
