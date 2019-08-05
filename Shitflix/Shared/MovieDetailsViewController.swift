import UIKit

/*
 NOTE: this ViewController needs just the id of the movie
 instead of the whole Movie object since it will have to
 make a new call to retrieve further details about it
 */
class MovieDetailsViewController: UIViewController {
    
    var movieID: Int? {
        didSet {
            update()
        }
    }
    
    /*
     MovieDetailsViewController can be created by another MovieDetailsViewController.
     To be able to dismiss all the stack in a single shot this closure must always
     refer to the one defined by the creator of the first one.
     */
    var didTapClose: (() -> ())?
    
    var isRootDetails = false
    
    override func loadView() {
        let v = MovieDetailsView()
        
        v.didSwipeDown = { [weak self] in
            self?.dismiss(animated: true)
        }
        v.didTapClose = didTapClose
        v.didSelectMovie = showDetailsOfMovie(withId:)
        
        // TODO inject closures, verify reference cycle
        
        self.view = v
    }
    
    private func update() {
        guard let movieID = self.movieID else { return }
        
        TMDService.getMovie(id: movieID, then: { result in
            switch result {
            case .success(let movie):
                (self.view as! MovieDetailsView).movie = movie
            case .failure(let error):
                print("Failure while retrieving details about movie with id \(self.movieID!)")
                print(error)
            }
        })
        
        TMDService.getReccomendations(for: movieID, then: { result in
            switch result {
            case .success(let movies):
                let n = min(movies.count - 1, 5)
                (self.view as! MovieDetailsView).correlatedMovies = Array(movies[0...n])
            case .failure(let error):
                print("Failure while retrieving details about movie with id \(self.movieID!)")
                print(error)
            }
        })
    }
    
    private func showDetailsOfMovie(withId id: Int) {
        let movieDetailsVC = MovieDetailsViewController()
        movieDetailsVC.movieID = id
        // propagate the original closure inside the childs
        movieDetailsVC.didTapClose = self.didTapClose
        self.present(movieDetailsVC, animated: true)
    }
}
