//
//  MovieCell.swift
//  Magnum Opus
//
//  Created by Cem Kılıç on 26.04.2022.
//

import UIKit
import Kingfisher

class MovieCell: UICollectionViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //
    func configure(movie: Movie, side: NSTextAlignment,_ similar: Bool = false){
        titleLabel.textAlignment = side
        detailLabel.textAlignment = side
        
        if let path = movie.posterPath  {
            let url = URL(string: "https://www.themoviedb.org/t/p/w185/" + path)
            movieImage.kf.setImage(with: url)
        }
        titleLabel.text = movie.title
        titleLabel.textColor = UIColor.Theme.darkPurple3
        if let release = movie.releaseDate, let genres = movie.genres {
            detailLabel.text = "(" + release + ")\n" + genres.joined(separator: ", ")
        }
        else if let release = movie.releaseDate, release != "" {
            detailLabel.text = "(" + release + ")"
        }
        
        if similar{
            movieImage.translatesAutoresizingMaskIntoConstraints = false
            movieImage.heightAnchor.constraint(equalToConstant: 125).isActive = true
            movieImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
            titleLabel.numberOfLines = 2
        }
    }
}
