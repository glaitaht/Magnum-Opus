//
//  SearchResultViewController.swift
//  Magnum Opus
//
//  Created by Cem Kılıç on 28.04.2022.
//

import UIKit

protocol SearchResultViewControllerProtocol: AnyObject {
    func reloadData()
    func showLoadingView()
    func hideLoadingView()
}

final class SearchResultViewController: UIViewController, LoadingShowable{
    @IBOutlet weak var searchedCollectionView: UICollectionView!
    
    var presenter: SearchResultPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchedCollectionView.delegate = self
        searchedCollectionView.dataSource = self
        searchedCollectionView.register(cellType: MovieCell.self)
        searchedCollectionView.fixSharping(view: searchedCollectionView, type: .continuous, radius: 15, color: .Theme.darkPurple3, width: 1)
        self.view.backgroundColor = .Theme.black.withAlphaComponent(0.4)
    }
    
    func getSearchedText(movieName: String) {
        presenter?.fetchSearchedMovie(movieName: movieName)
    }
    
    func setZero(){
        searchedCollectionView.setContentOffset(CGPoint.zero, animated: false)
    }
}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if presenter?.numberOfItems() == 0{
            let imageView = UIImageView()
            imageView.image = UIImage(named: "notfound")
            imageView.frame = collectionView.frame
            collectionView.backgroundView = imageView
        }
        else{
            collectionView.backgroundView = UIView()
        }
        
        return presenter?.numberOfItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: MovieCell.self, indexPath: indexPath)
        if let movie = presenter?.movie(indexPath.row) {
            cell.configure(movie: movie, side: .center)
        }
        //cell.fixSharping(view: cell, color: .Theme.darkPurple1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 175, height: searchedCollectionView.frame.height - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

extension SearchResultViewController: SearchResultViewControllerProtocol {
    
    func reloadData() {
        searchedCollectionView.reloadData()
    }
    
    func showLoadingView() {
        showLoading(searchedCollectionView)
    }
    
    func hideLoadingView() {
        hideLoading()
    }

}
