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
    private var addToListBtn = UIButton()
    private var addToListLbl = UILabel()
    private var playBtn = UIButton()
    private var infoBtn = UIButton()
    private var infoLbl = UILabel()
    
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
        self.contentView.addSubview(addToListLbl)
        self.contentView.addSubview(playBtn)
        self.contentView.addSubview(infoBtn)
        self.contentView.addSubview(infoLbl)
        
        addToListBtn.addTarget(self, action: #selector(onAddToList), for: .touchUpInside)
        playBtn.addTarget(self, action: #selector(onPlay), for: .touchUpInside)
        infoBtn.addTarget(self, action: #selector(onInfo), for: .touchUpInside)
    }
    
    private func style() {
        self.clipsToBounds = true
        
        addToListBtn.setImage(UIImage(named: "add-button-normal"), for: .normal)
        addToListLbl.text = "La mia lista"
        addToListLbl.font = UIFont(name: "Gotham-Book", size: 12)
        addToListLbl.textColor = .white
        addToListLbl.textAlignment = .center
        
        playBtn.setImage(UIImage(named: "play-button-black"), for: .normal)
        playBtn.setTitle("  Riproduci", for: .normal)
        playBtn.setTitleColor(.black, for: .normal)
        playBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        playBtn.backgroundColor = .white
        
        infoBtn.setImage(UIImage(named: "info-icon-normal"), for: .normal)
        infoLbl.text = "Info"
        infoLbl.font = UIFont(name: "Gotham-Book", size: 12)
        infoLbl.textColor = .white
        infoLbl.textAlignment = .center
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
        
        let iconSize = CGFloat(30)
        let labelW = CGFloat(70)
        let labelH = CGFloat(20)
        let playW = CGFloat(120)
        let playH = CGFloat(35)
        
        let buttonsY = CGFloat(490)
        let labelsY = buttonsY + 30
        
        poster.frame = CGRect(
            x: 0,
            y: 0,
            width: w,
            height: h
        )
        poster.fadeView(style: .bottom, percentage: 0.15)
        
        addToListBtn.frame = CGRect(
            x: w * 0.15 - iconSize/2,
            y: buttonsY - iconSize/2,
            width: iconSize,
            height: iconSize
        )
        addToListLbl.frame = CGRect(
            x: w * 0.15 - labelW/2,
            y: labelsY - labelH/2,
            width: labelW,
            height: labelH
        )
        
        playBtn.frame = CGRect(
            x: w * 0.5 - playW/2,
            y: buttonsY - playH/2,
            width: playW,
            height: playH
        )
        playBtn.layer.cornerRadius = 3
        
        infoBtn.frame = CGRect(
            x: w * 0.85 - iconSize/2,
            y: buttonsY - iconSize/2,
            width: iconSize,
            height: iconSize
        )
        infoLbl.frame = CGRect(
            x: w * 0.85 - labelW/2,
            y: labelsY - labelH/2,
            width: labelW,
            height: labelH
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
