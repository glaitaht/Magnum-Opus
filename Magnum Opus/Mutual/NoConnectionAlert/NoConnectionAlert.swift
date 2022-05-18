//
//  NoConnectionAlert.swift
//  Magnum Opus
//
//  Created by Cem Kılıç on 1.05.2022.
//

import UIKit

class NoConnectionAlert: UIViewController {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var imageCardView: UIView!
    @IBOutlet weak var errorText: UILabel!
    @IBOutlet weak var errorDetail: UILabel!
    @IBOutlet var wifiImage: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .Theme.black
        cardView.backgroundColor = .Theme.black
        wifiImage.tintColor = .Theme.pink
        errorText.textColor = .Theme.pink
        errorDetail.textColor = .Theme.pink
        imageCardView.fixSharping(view: imageCardView, type: .continuous, radius: 15, color: .Theme.pink, width: 3)
        cardView.fixSharping(view: cardView, type: .continuous, radius: 15, color: .Theme.pink, width: 3)
        imageCardView.backgroundColor = .Theme.black
    }

}
