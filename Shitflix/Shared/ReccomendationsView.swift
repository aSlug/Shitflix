import UIKit

class ReccomendationsView: UIView {
    
    var movies: [Movie]? {
        didSet {
            update()
        }
    }
    
    var didSelectMovie: ((Int) -> ())?
    
    private var posters: [PosterCell] = Array(repeating: PosterCell(), count: 6)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        style()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        for poster in posters {
            self.addSubview(poster)
        }
    }
    
    private func style() {
    }
    
    private func update() {
        
        if let movies = self.movies {
            guard movies.count <= 6 else {
                fatalError("ReccomendationsView has been provided with excessive number of Movie objects")
            }
            for (i, movie) in movies.enumerated() {
                posters[i].movie = movie
                posters[i].didSelectMovie = didSelectMovie
            }
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // display the posters in a 3x2 grid
        let margin = 15
        let posterW = (Int(self.bounds.width) - margin * 4) / 3
        let posterH = posterW * 3/2
        
        for (i, poster) in posters.enumerated() {
            let r: Int = (i / 3) + 1
            let c: Int = (i % 3) + 1
            poster.frame = CGRect(
                x: (margin * c) + (posterW * (c-1)),
                y: (margin * r) + (posterH * (r-1)),
                width: posterW,
                height: posterH
            )
        }
        
    }
    
}
