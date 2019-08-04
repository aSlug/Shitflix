import UIKit

class MovieDetailsView: UIView {
    
    var movie: Movie? {
        didSet {
            update()
        }
    }
    
    private var poster = UIImageView()
    private var releaseYear = UILabel()
    private var runtime = UILabel()
    private var overview = UILabel()
    
    private var playBtn = UIButton()
    private var addToListBtn = UIButton()
    private var likeBtn = UIButton()
    private var shareBtn = UIButton()
    private var downloadBtn = UIButton()
    
    var didPlay: ((Movie) -> ())?
    var didToggleAddToList: ((Movie) -> ())?
    var didToggleLike: ((Movie) -> ())?
    var didShare: ((Movie) -> ())?
    var didDownload: ((Movie) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // TODO
        setup()
        style()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.addSubview(poster)
        self.addSubview(releaseYear)
        self.addSubview(runtime)
        self.addSubview(overview)
        
        self.addSubview(playBtn)
        self.addSubview(addToListBtn)
        self.addSubview(likeBtn)
        self.addSubview(shareBtn)
        self.addSubview(downloadBtn)
        
        playBtn.addTarget(self, action: #selector(onPlay), for: .touchUpInside)
        addToListBtn.addTarget(self, action: #selector(onAdd), for: .touchUpInside)
        likeBtn.addTarget(self, action: #selector(onLike), for: .touchUpInside)
        shareBtn.addTarget(self, action: #selector(onShare), for: .touchUpInside)
        downloadBtn.addTarget(self, action: #selector(onDownload), for: .touchUpInside)
    }
    
    private func style() {
        
        /* add blurr effect over background image */
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
        
        playBtn.setImage(UIImage(named: "play-button-white"), for: .normal)
        playBtn.setTitle("Play", for: .normal)
        playBtn.backgroundColor = UIColor(hex: Palette.shitflix)
        playBtn.setTitleColor(.white, for: .normal)
        
        addToListBtn.setImage(UIImage(named: "add-button-normal"), for: .normal)
        likeBtn.setImage(UIImage(named: "like-button-normal"), for: .normal)
        shareBtn.setImage(UIImage(named: "share-button-normal"), for: .normal)
        downloadBtn.setImage(UIImage(named: "download-button-normal"), for: .normal)
    }
    
    private func update() {
        guard let movie = movie else { return }
        
        TMDService.fetchImage(from: self.movie!.posterPath, ofSize: .w342) { result in
            switch result {
            case .success(let image):
                self.backgroundColor = UIColor(patternImage: image)
                self.poster.image = image
            case .failure(let error):
                print("Failure while retrieving image for movie \(self.movie!.title) from url \(self.movie!.posterPath)")
                print(error)
            }
        }
        
        if movie.releaseDate != nil {
            let yearFormatter = DateFormatter()
            yearFormatter.dateFormat = "yyyy"
            releaseYear.text = yearFormatter.string(from: movie.releaseDate!)
        } else {
            releaseYear.text = "----"
        }
        
        if movie.runtime != nil {
            runtime.text = "\(movie.runtime! / 60)h \(movie.runtime! % 60)m"
        } else {
            runtime.text = "-h --m"
        }
        
        overview.text = movie.overview ?? ""
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let w = Int(self.bounds.width)
        let posterW = 110
        let posterH = posterW * 3/2
        
        poster.frame = CGRect(x: w/2 - posterW/2, y: 40, width: posterW, height: posterH)
        
        releaseYear.frame = CGRect(x: w * 1/3 - 25, y: 40 + posterH + 15, width: 50, height: 20)
        runtime.frame = CGRect(x: w * 2/3 - 25, y: 40 + posterH + 15, width: 50, height: 20)
        
        playBtn.frame = CGRect(x: 10, y: posterH + 105, width: w - 20, height: 30)
        
        overview.frame = CGRect(x: 10, y: posterH + 40, width: w - 20, height: 50)
        
        let btnSize = 25
        addToListBtn.frame = CGRect(x: w * 1/8 - btnSize/2, y: posterH + 100, width: btnSize, height: btnSize)
        likeBtn.frame = CGRect(x: w * 3/8 - btnSize/2, y: posterH + 100, width: btnSize, height: btnSize)
        shareBtn.frame = CGRect(x: w * 5/8 - btnSize/2, y: posterH + 100, width: btnSize, height: btnSize)
        downloadBtn.frame = CGRect(x: w * 7/8 - btnSize/2, y: posterH + 100, width: btnSize, height: btnSize)
    }
    
    @objc func onPlay() {
        print("Click on play button")
        guard let movie = self.movie else {return}
        self.didPlay?(movie)
    }
    @objc func onAdd() {
        print("Click on add button")
        guard let movie = self.movie else {return}
        self.didToggleAddToList?(movie)
    }
    @objc func onLike() {
        print("Click on like button")
        guard let movie = self.movie else {return}
        self.didToggleLike?(movie)
    }
    @objc func onShare() {
        print("Click on share button")
        guard let movie = self.movie else {return}
        self.didShare?(movie)
    }
    @objc func onDownload() {
        print("Click on download button")
        guard let movie = self.movie else {return}
        self.didDownload?(movie)
    }
    
}
