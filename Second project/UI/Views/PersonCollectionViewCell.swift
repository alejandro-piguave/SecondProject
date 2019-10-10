//
//  PersonCellCollection.swift
//  Second project
//
//  Created by Dev2 on 03/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit
import Kingfisher

class PersonCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var personView: UIView! {
        didSet {
            // corner radius
            personView.layer.cornerRadius = 10
            
            // shadow
            personView.layer.shadowColor = UIColor.black.cgColor
            personView.layer.shadowOffset = CGSize(width: 3, height: 3)
            personView.layer.shadowOpacity = 0.7
            personView.layer.shadowRadius = 4.0
        }
    }
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personNameLabel: UILabel!

    
    func configure(from user: User) {
        if let userImg = user.img {
            let url = URL(string: userImg)
            personImage.kf.setImage(with: url)
        }
        personNameLabel.text = user.name
    }
}
