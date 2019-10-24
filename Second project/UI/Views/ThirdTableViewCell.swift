//
//  ThirdTableViewCell.swift
//  Second project
//
//  Created by Dev2 on 16/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class ThirdTableViewCell: UITableViewCell {

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
    @IBOutlet weak var personLocationLabel: UILabel!
    @IBOutlet weak var personStreetLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(from user: User) {
        personLocationLabel.text = user.location
        personStreetLabel.text = user.streetInfo
    }
    
}
