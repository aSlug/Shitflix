import UIKit

class PosterGrid: UIView {
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var movies: [Movie]? {
        didSet {
            update()
        }
    }
    
    var didSelectMovie: ((Int) -> ())? {
        didSet {
            /* once available propagate the closure in the childs */
            for poster in posters {
                poster.didSelectMovie = self.didSelectMovie
            }
        }
    }
    
    private var titleLabel = UILabel()
    private var posters: [PosterCell] = [
        PosterCell(),
        PosterCell(),
        PosterCell(),
        PosterCell(),
        PosterCell(),
        PosterCell()
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        style()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.addSubview(titleLabel)
        for poster in posters {
            self.addSubview(poster)
        }
    }
    
    private func style() {
        titleLabel.textColor = .white
        titleLabel.font =  UIFont.systemFont(ofSize: 18, weight: .heavy)
    }
    
    private func update() {
        
        if let movies = self.movies {
            guard movies.count <= 6 else {
                fatalError("ReccomendationsView has been provided with excessive number of Movie objects")
            }
            for (i, movie) in movies.enumerated() {
                posters[i].movie = movie
            }
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = UIColor(hex: Palette.background)
        
        titleLabel.frame = CGRect(x: 15, y: 15, width: 200, height: 20)
        
        // display the posters in a 3x2 grid
        let margin = 15
        let posterW = (Int(self.bounds.width) - margin * 4) / 3
        let posterH = posterW * 3/2
        
        for (i, poster) in posters.enumerated() {
            let r: Int = (i / 3) + 1
            let c: Int = (i % 3) + 1
            poster.frame = CGRect(
                x: (margin * c) + (posterW * (c-1)),
                y: 40 + (margin * r) + (posterH * (r-1)),
                width: posterW,
                height: posterH
            )
        }
        
    }
    
}
