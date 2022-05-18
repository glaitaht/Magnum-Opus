//
//  ShowDetailViewController.swift
//  Magnum Opus
//
//  Created by Cem Kılıç on 29.04.2022.
//

import UIKit
import Kingfisher

protocol ShowDetailViewControllerProtocol: AnyObject {
    func reloadData()
    func showLoadingView()
    func hideLoadingView()
    func setupViews()
    func setTitle(title: String)
    func setupMovieDetail(movieDetail: MovieDetailResult)
    func setFav(isItFav: Bool)
}
final class ShowDetailViewController: UIViewController, LoadingShowable {
    
    @IBOutlet weak var similarCollectionView: UICollectionView!
    @IBOutlet weak var movieDetailLabel: UITextView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var imdbRate: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var imdbImage: UIImageView!
    @IBOutlet weak var favButton: UIImageView!
    
    var presenter: ShowDetailPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    func viewConstraints(){
        self.navigationController?.navigationBar.tintColor = .Theme.darkPurple3
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.Theme.pink]
        
        let heightOfDevice = UIScreen.main.bounds.height
        if(heightOfDevice < 650){
            movieImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
            nameTitle.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 7).isActive = true
            nameTitle.bottomAnchor.constraint(equalTo: movieDetailLabel.topAnchor, constant: -3).isActive = true
            movieDetailLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            movieDetailLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            similarCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        }
        else if(heightOfDevice < 850){
            movieImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        }
        
        let favTapped = UITapGestureRecognizer(target: self, action: #selector(self.Favtapped))
        favButton.addGestureRecognizer(favTapped)
        favButton.isUserInteractionEnabled = true
    }
    
    @objc func IMDBtapped(sender: IMDBTapGesture){
        guard let url = URL(string: "https://www.imdb.com/title/"+sender.imdbID) else { return }
        UIApplication.shared.open(url)
    }
    
    @objc func Favtapped(){
        presenter?.favClicked()
    }
}

extension ShowDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.numberOfItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: MovieCell.self, indexPath: indexPath)
        if let movie = presenter?.movie(indexPath.row) {
            cell.configure(movie: movie, side: .center, true)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 125, height: 225)
    }
}

extension ShowDetailViewController: ShowDetailViewControllerProtocol {
    
    func reloadData() {
        similarCollectionView.reloadData()
    }
    
    func showLoadingView() {
        showLoading()
    }
    
    func hideLoadingView() {
        hideLoading()
    }
    
    func setTitle(title: String) {
        //var title = title.count > 12 ? String(title.prefix(11) + "...") : title
        self.title = title
    }
    
    func setupViews() {
        similarCollectionView.register(cellType: MovieCell.self)
        similarCollectionView?.dataSource = self
        similarCollectionView?.delegate = self
        viewConstraints()
    }
    
    func setupMovieDetail(movieDetail: MovieDetailResult) {
        if let movieTitle = movieDetail.title{
            self.nameTitle.text = movieTitle
        }
        if let movieDetail = movieDetail.overview{
            self.movieDetailLabel.text = movieDetail
        }
        if let movieImage = movieDetail.backdropPath{
            let url = URL(string: "https://www.themoviedb.org/t/p/original/" + movieImage)
            self.movieImage.kf.setImage(with: url)
        }
        if let rate = movieDetail.voteAverage{
            self.imdbRate.text = String(rate)
        }
        if let releaseDate = movieDetail.releaseDate{
            self.releaseDate.text = releaseDate
        }
        if let imdb = movieDetail.imdbID{
            let imdbTapGesture = IMDBTapGesture(target: self, action: #selector(self.IMDBtapped))
            imdbTapGesture.imdbID = imdb
            imdbImage.addGestureRecognizer(imdbTapGesture)
            imdbImage.isUserInteractionEnabled = true

        }
    }
    
    func setFav(isItFav: Bool){
        if isItFav{
            UIView.transition(with: favButton,
                              duration: 0.3,
                              options: .transitionFlipFromBottom,
                              animations: { self.favButton.image = UIImage(systemName: "heart.fill") },
                              completion: nil)
        }
        else{
            UIView.transition(with: favButton,
                              duration: 0.3,
                              options: .transitionFlipFromBottom,
                              animations: { self.favButton.image = UIImage(systemName: "heart") },
                              completion: nil)
        }
    }
}
