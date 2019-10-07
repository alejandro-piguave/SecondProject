//
//  PersonCellCollection.swift
//  Second project
//
//  Created by Dev2 on 03/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class PersonCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBOutlet weak var subjectView: UIView! {
        didSet {
            // corner radius
            subjectView.layer.cornerRadius = 10
            
            // shadow
            subjectView.layer.shadowColor = UIColor.black.cgColor
            subjectView.layer.shadowOffset = CGSize(width: 3, height: 3)
            subjectView.layer.shadowOpacity = 0.7
            subjectView.layer.shadowRadius = 4.0
        }
    }
    @IBOutlet weak var subjectImage: UIImageView!
    @IBOutlet weak var subjectNameLabel: UILabel!

}
