//
//  PaginationCell.swift
//  Magnum Opus
//
//  Created by Cem Kılıç on 3.05.2022.
//

import UIKit

class PaginationCell: UICollectionViewCell {
    @IBOutlet weak var previousPageButton: UIButton!
    @IBOutlet weak var nextPageButton: UIButton!
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var pageNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        previousPageButton.tintColor = .Theme.pink
        previousPageButton.backgroundColor = .Theme.black
        nextPageButton.tintColor = .Theme.pink
        nextPageButton.backgroundColor = .Theme.black
        pageLabel.textColor = .Theme.pink
        pageNumber.textColor = .Theme.pink
        let heightOfDevice = UIScreen.main.bounds.height
        if heightOfDevice < 650{
            previousPageButton.setTitle("<", for: .normal)
            nextPageButton.setTitle(">", for: .normal)
            previousPageButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
            nextPageButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        }
    }

}
