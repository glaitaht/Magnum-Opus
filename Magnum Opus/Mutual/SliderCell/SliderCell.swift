//
//  SliderCell.swift
//  Magnum Opus
//
//  Created by Cem Kılıç on 28.04.2022.
//

import UIKit
import Kingfisher

class SliderCell: UICollectionViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nowPlayingView: UIView!
    
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nowPlayingView.backgroundColor = UIColor.Theme.pink
        nowPlayingView.alpha = 0.5
        nowPlayingView.fixSharping(view: nowPlayingView, type: .continuous, radius: 10, color: UIColor.Theme.darkPurple1, width: 2)
    }
    
    func configure(movie: Movie){
        if let path = movie.backdropPath  {
            let url = URL(string: "https://www.themoviedb.org/t/p/original/" + path)
            poster.kf.setImage(with: url)
        }
        titleLabel.text = movie.title
        titleLabel.textColor = UIColor.Theme.black
        if let rate = movie.voteAverage{
            arrangeStars(rate: rate/2)
        }
    }
    
    fileprivate func arrangeStars(rate: Double){
        let starArray: [UIImageView] = [star1,star2,star3,star4,star5]
        var rateToLoop = rate
        var star = 0
        while rateToLoop >= 1{
            starArray[star].image = UIImage(systemName: "star.fill")
            star+=1
            rateToLoop-=1
        }
        if rateToLoop > 0.49{
            starArray[star].image = UIImage(systemName: "star.leadinghalf.filled")
            star+=1
        }
        while star < 5{
            starArray[star].image = UIImage(systemName: "star")
            star+=1
        }
    }
}
