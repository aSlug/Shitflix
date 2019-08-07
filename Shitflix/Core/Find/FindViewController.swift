import UIKit

class FindViewController: UIViewController {
    
    override func loadView() {
        let v = FindView()
        v.didInputSearchKey = callFindService
        v.didSelectMovie = showDetailsOfMovie
        self.view = v
    }
    
    private func callFindService(withKeyword key: String) {
        TMDService.searchMovie(with: key, then: { result in
            switch result {
            case .success(let movies):
                (self.view as! FindView).movieList = movies
            case .failure(let error):
                print("Failure while retrieving movies with key \(key)")
                print(error)
            }
        })
    }
    
    private func showDetailsOfMovie(withId id: Int) {
        let movieDetailsVC = MovieDetailsViewController()
        movieDetailsVC.movieID = id
        movieDetailsVC.didTapClose = { [weak self] in
            self?.dismiss(animated: false)
        }
        self.present(movieDetailsVC, animated: true)
    }
    
}
