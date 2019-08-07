import UIKit

class FindView: UIView {
    
    var didInputSearchKey: ((String) -> ())?
    var didSelectMovie: ((Int) -> ())?
    
    var movieList: [Movie]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let searchBar = UISearchBar()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        style()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.addSubview(searchBar)
        self.addSubview(collectionView)
        
        searchBar.delegate = self

        layout.scrollDirection = .vertical
        collectionView.dataSource = self
        collectionView.register(PosterCell.self,
                                forCellWithReuseIdentifier: PosterCell.rID)
    }
    
    private func style() {
        searchBar.barStyle = .black
        searchBar.placeholder = "Cerca"
        // TODO improve the style of the searchbar
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let w = Int(self.bounds.width)
        let y = Int(self.bounds.height)
        let searchH = 80
        let margin = 15
        let posterW = (Int(self.bounds.width) - margin * 4) / 3
        let posterH = posterW * 3/2
        
        searchBar.frame = CGRect(x: 0, y: 0, width: w, height: searchH)
        searchBar.searchFieldBackgroundPositionAdjustment.vertical = CGFloat(searchH - 65)
        
        collectionView.frame = CGRect(x: 0, y: searchH, width: w, height: y - searchH)
        layout.itemSize = CGSize(width: posterW, height: posterH)
        layout.sectionInset = UIEdgeInsets(top: CGFloat(margin), left: CGFloat(margin), bottom: CGFloat(margin), right: CGFloat(margin))
    }
    
    // quick accessor to collectionView layout bypassing cast
    private var layout: UICollectionViewFlowLayout {
        return collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    }
    
}

extension FindView: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let key = searchBar.text else { return }
        self.didInputSearchKey?(key)
        print("searchBarSearchButtonClicked, input is \(searchBar.text ?? "")")
    }
    
    // TODO: empty the results when searchbar is emptied
    
}

extension FindView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let posterCell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCell.rID, for: indexPath) as! PosterCell
        posterCell.movie = movieList?[indexPath.row]
        posterCell.didSelectMovie = self.didSelectMovie
        
        return posterCell
    }
    
}
