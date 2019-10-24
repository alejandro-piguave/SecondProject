//
//  FirstTableViewCell.swift
//  Second project
//
//  Created by Dev2 on 16/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class FirstTableViewCell: UITableViewCell {
    
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
    
    @IBOutlet weak var personImage: UIImageView! {
        didSet {
            personImage.layer.masksToBounds = false
            personImage.layer.cornerRadius = personImage.frame.height/2
            personImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var personAgeLabel: UILabel!
    @IBOutlet weak var personGenderLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(from user: User) {
        if let userImg = user.img {
            let url = URL(string: userImg)
            personImage.kf.setImage(with: url)
        }
        personAgeLabel.text = user.dobInfo
        personNameLabel.text = user.fullName
        personGenderLabel.text = user.genderEmoji
    }
    
}
