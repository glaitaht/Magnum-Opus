//
//  ListViewController.swift
//  Magnum Opus
//
//  Created by Cem Kılıç on 27.04.2022.
//

import UIKit

protocol ListViewControllerProtocol: AnyObject {
    func reloadData()
    func showLoadingView()
    func hideLoadingView()
    func setupViews()
    func reloadSlider()
}

final class ListViewController: UIViewController, LoadingShowable{
    @IBOutlet weak var carouselView: UICollectionView!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
     private var searchController: UISearchController!
     var searchResultView: SearchResultViewController!
    
    var presenter: ListViewPresenterProtocol!
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.count < 3
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let flowLayout = moviesCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
              flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        presenter.viewDidLoad()
    }
    
    private func searchControllerConfigure(){
        searchController = UISearchController(searchResultsController: searchResultView)
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.becomeFirstResponder()
        searchController.searchBar.tintColor = UIColor.Theme.darkPurple3
        searchController.searchBar.searchTextField.textColor = UIColor.Theme.pink
        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.Theme.black
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.standardAppearance = appearance
        searchController.searchBar.accessibilityIdentifier = "searchbar"
    }
    
    private func viewConstraints(){
        carouselView.backgroundColor = .clear
        carouselView?.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.33).isActive = true
        carouselView.fixSharping(view: carouselView, type: .continuous, radius: 15, color: UIColor.Theme.pink, width: 1)
        //searchController.searchBar.fixSharping(view: searchController.searchBar, type: .continuous, radius: 15, color: UIColor.Theme.pink, width: 1)
    }
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @objc func fetchPreviousPage() {
        presenter.fetchNewPage(page: .previousPage)
        moviesCollectionView.setContentOffset(.zero, animated: true)
    }
    
    @objc func fetchNextPage() {
        presenter.fetchNewPage(page: .nextPage)
        moviesCollectionView.setContentOffset(.zero, animated: true)
    }
    
    func arrangePaginationButtons(cell: PaginationCell){
        let (active,total) = presenter.getPageInfo()
        var isPreHidden = false
        var isNextHidden = false
        (active == 0) ? (isPreHidden = true) : (isPreHidden = false)
        (active == total-1) ? (isNextHidden = true) : (isNextHidden = false)
        cell.previousPageButton.isHidden = isPreHidden
        cell.nextPageButton.isHidden = isNextHidden
        cell.pageNumber.text = String(active+1) + "/" + String(total)
        cell.previousPageButton.addTarget(self, action: #selector(fetchPreviousPage), for: .touchUpInside)
        cell.nextPageButton.addTarget(self, action: #selector(fetchNextPage), for: .touchUpInside)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == moviesCollectionView{
            return presenter.numberOfItems()+1
        }
        else if collectionView == carouselView{
            return 5
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == moviesCollectionView {
            if indexPath.row == presenter.numberOfItems() {
                let cell = collectionView.dequeCell(cellType: PaginationCell.self, indexPath: indexPath)
                arrangePaginationButtons(cell: cell)
                return cell
            }
            let cell = collectionView.dequeCell(cellType: MovieCell.self, indexPath: indexPath)
            if let movie = presenter.movie(indexPath.row) {
                cell.configure(movie: movie, side: indexPath.row%2==0 ? .left : .right)
            }
            return cell
        }
        else if collectionView == carouselView {
            let cell = collectionView.dequeCell(cellType: SliderCell.self, indexPath: indexPath)
            if let movie = presenter.slider(indexPath.row) {
                cell.configure(movie: movie)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == moviesCollectionView{
            presenter.didSelectRowAt(index: indexPath.row, type: true)
        }
        else{
            presenter.didSelectRowAt(index: indexPath.row, type: false)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == carouselView {
            return CGSize(width: carouselView.frame.width, height: carouselView.frame.height)
        }
        else if collectionView == moviesCollectionView{
            let cell = collectionView.dequeCell(cellType: MovieCell.self, indexPath: indexPath)
            if indexPath.row == presenter.numberOfItems() {
                return CGSize(width: view.frame.width, height: 100)
            }
            return CGSize(width: cell.frame.width, height: cell.frame.height)
        }
        return CGSize(width: 0, height: 0)
    }
     
}

extension ListViewController: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate{
    
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchResultsController?.view.isHidden = true
        if isFiltering{
            searchController.searchResultsController?.view.isHidden = false
            //searchController.searchResultsController?.view.fadeIn(0.2)
            if let controller = searchController.searchResultsController as? SearchResultViewController, let text = searchController.searchBar.text {
                controller.setZero()
                controller.getSearchedText(movieName: text)
            }
        }
    }
    
}

extension ListViewController: ListViewControllerProtocol{
    
    func reloadData() {
        moviesCollectionView?.reloadData()
    }
    
    func showLoadingView() {
        showLoading()
    }
    
    func hideLoadingView() {
        hideLoading()
    }
    
    func setupViews() {
        moviesCollectionView.register(cellType: MovieCell.self)
        moviesCollectionView.register(cellType: PaginationCell.self)
        moviesCollectionView?.dataSource = self
        moviesCollectionView?.delegate = self
        carouselView.dataSource = self
        carouselView.delegate = self
        carouselView.register(cellType: SliderCell.self)
        viewConstraints()
        searchControllerConfigure()
    }
    
    func reloadSlider() {
        carouselView.reloadData()
        for i in 1...14{
            Timer.scheduledTimer(withTimeInterval: TimeInterval(i*4), repeats: false) { [weak self] timer in
                self?.carouselView.scrollToItem(at: IndexPath(item: i%5, section: 0), at: UICollectionView.ScrollPosition.right, animated: true)
            }
        }
    }
}
