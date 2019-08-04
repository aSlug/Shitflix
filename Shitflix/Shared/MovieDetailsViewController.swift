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
    
    override func loadView() {
        let v = MovieDetailsView()
        // TODO inject closures
        self.view = v
    }
    
    private func update() {
        guard movieID != nil else { return }
        
        TMDService.getMovie(id: movieID!, then: { result in
            switch result {
            case .success(let movie):
                (self.view as! MovieDetailsView).movie = movie
            case .failure(let error):
                print("Failure while retrieving details about movie with id \(self.movieID!)")
                print(error)
            }
        })
        
    }
    
}
