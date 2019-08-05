import UIKit

class MovieDetailsView: UIView {
    
    var movie: Movie? {
        didSet {
            update()
        }
    }
    
    var correlatedMovies: [Movie]? {
        didSet {
            update()
        }
    }
    
    private var closeBtn = UIButton()
    
    private var poster = UIImageView()
    private var releaseYear = UILabel()
    private var runtime = UILabel()
    private var overview = UILabel()
    
    private var playBtn = UIButton()
    private var addToListBtn = UIButton()
    private var likeBtn = UIButton()
    private var shareBtn = UIButton()
    private var downloadBtn = UIButton()
    
    private var blur = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.dark))
    
    private var reccomendations = PosterGrid()
    
    var didPlay: ((Movie) -> ())?
    var didToggleAddToList: ((Movie) -> ())?
    var didToggleLike: ((Movie) -> ())?
    var didShare: ((Movie) -> ())?
    var didDownload: ((Movie) -> ())?
    
    var didSelectMovie: ((Int) -> ())? {
        didSet {
            /* once available propagate the closure in the childs */
            reccomendations.didSelectMovie = didSelectMovie
        }
    }
    
    var didTapClose: (() -> ())?
    var didSwipeDown: (() -> ())?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        style()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.addSubview(blur)
        
        self.addSubview(closeBtn)
        
        self.addSubview(poster)
        self.addSubview(releaseYear)
        self.addSubview(runtime)
        self.addSubview(overview)
        
        self.addSubview(playBtn)
        self.addSubview(addToListBtn)
        self.addSubview(likeBtn)
        self.addSubview(shareBtn)
        self.addSubview(downloadBtn)
        
        closeBtn.addTarget(self, action: #selector(onTapClose), for: .touchUpInside)
        
        playBtn.addTarget(self, action: #selector(onPlay), for: .touchUpInside)
        addToListBtn.addTarget(self, action: #selector(onAdd), for: .touchUpInside)
        likeBtn.addTarget(self, action: #selector(onLike), for: .touchUpInside)
        shareBtn.addTarget(self, action: #selector(onShare), for: .touchUpInside)
        downloadBtn.addTarget(self, action: #selector(onDownload), for: .touchUpInside)
        
        self.addSubview(reccomendations)
        reccomendations.title = "ALTRI SIMILI"
        reccomendations.movies = correlatedMovies
        
        // the user closes the detail view by swiping down
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeDown))
        swipeGesture.direction = .down
        self.addGestureRecognizer(swipeGesture)
    }
    
    private func style() {
        
        // add blurr effect over background image
        blur.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        closeBtn.setImage(UIImage(named: "close-icon"), for: .normal)
        
        poster.layer.shadowColor = UIColor.black.cgColor
        poster.layer.shadowOpacity = 0.7
        poster.layer.shadowRadius = 8
        
        playBtn.setImage(UIImage(named: "play-button-white"), for: .normal)
        playBtn.setTitle("  Riproduci", for: .normal)
        playBtn.backgroundColor = UIColor(hex: Palette.shitflix)
        playBtn.setTitleColor(.white, for: .normal)
        playBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
        addToListBtn.setImage(UIImage(named: "add-button-normal"), for: .normal)
        likeBtn.setImage(UIImage(named: "like-button-normal"), for: .normal)
        shareBtn.setImage(UIImage(named: "share-button-normal"), for: .normal)
        downloadBtn.setImage(UIImage(named: "download-button-normal"), for: .normal)
        
        releaseYear.textAlignment = .center
        releaseYear.font = UIFont(name: "Gotham-Book", size: 16)
        releaseYear.textColor = UIColor(hex: Palette.unselected)
        
        runtime.textAlignment = .center
        runtime.font = UIFont(name: "Gotham-Book", size: 16)
        runtime.textColor = UIColor(hex: Palette.unselected)
        
        overview.textAlignment = .justified
        overview.font = UIFont(name: "Gotham-Book", size: 15)
        overview.textColor = UIColor(hex: Palette.unselected)
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
        
        // pass the updated correlated movies to the subview
        reccomendations.movies = correlatedMovies
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        blur.frame = self.bounds
        
        let w = Int(self.bounds.width)
        let posterW = 130
        let posterH = posterW * 3/2
        
        let btnSize = 25
        
        let posterY = 60
        let infoY = posterY + posterH + 15
        let playY = infoY + 50
        let playH = 33
        let overviewY = playY + playH + 7
        let overviewH = 80
        let buttonsY = overviewY + overviewH + 20
        
        closeBtn.frame = CGRect(x: w - 35, y: 40, width: 25, height: 25)
        
        poster.frame = CGRect(x: w/2 - posterW/2, y: posterY, width: posterW, height: posterH)
        
        releaseYear.frame = CGRect(x: w * 4/10 - 35, y: posterY + posterH + 15, width: 70, height: 20)
        runtime.frame = CGRect(x: w * 6/10 - 35, y: posterY + posterH + 15, width: 70, height: 20)
        
        playBtn.frame = CGRect(x: 10, y: playY, width: w - 20, height: playH)
        playBtn.layer.cornerRadius = 3
        
        overview.frame = CGRect(x: 10, y: overviewY, width: w - 20, height: overviewH)
        overview.numberOfLines = 10
        overview.fadeView(style: .bottom, percentage: 0.50)
        
        addToListBtn.frame = CGRect(x: w * 1/8 - btnSize/2, y: buttonsY, width: btnSize, height: btnSize)
        likeBtn.frame = CGRect(x: w * 3/8 - btnSize/2, y: buttonsY, width: btnSize, height: btnSize)
        shareBtn.frame = CGRect(x: w * 5/8 - btnSize/2, y: buttonsY, width: btnSize, height: btnSize)
        downloadBtn.frame = CGRect(x: w * 7/8 - btnSize/2, y: buttonsY, width: btnSize, height: btnSize)
        
        reccomendations.frame = CGRect(x: 0, y: buttonsY + btnSize + 20, width: w, height: 600)
    }
    
    @objc private func onPlay() {
        print("Click on play button")
        guard let movie = self.movie else {return}
        self.didPlay?(movie)
    }
    @objc private func onAdd() {
        print("Click on add button")
        guard let movie = self.movie else {return}
        self.didToggleAddToList?(movie)
    }
    @objc private func onLike() {
        print("Click on like button")
        guard let movie = self.movie else {return}
        self.didToggleLike?(movie)
    }
    @objc private func onShare() {
        print("Click on share button")
        guard let movie = self.movie else {return}
        self.didShare?(movie)
    }
    @objc private func onDownload() {
        print("Click on download button")
        guard let movie = self.movie else {return}
        self.didDownload?(movie)
    }
    @objc private func onSwipeDown(_ s: UISwipeGestureRecognizer) {
        print("Swipe down on movie details view")
        self.didSwipeDown?()
    }
    @objc private func onTapClose() {
        print("Tap close on movie details view")
        self.didTapClose?()
    }
    
}
