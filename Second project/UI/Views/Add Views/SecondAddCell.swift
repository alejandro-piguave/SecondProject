//
//  SecondAddCell.swift
//  Second project
//
//  Created by Dev2 on 24/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class SecondAddCell: UITableViewCell {
    static var typeName: String {
        return String(describing: self)
    }
    @IBOutlet weak var personView: UIView! 
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var cellPhoneTF: UITextField!
    @IBOutlet weak var housePhoneTF: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()            // corner radius
        personView.layer.cornerRadius = 10
        
        // shadow
        personView.layer.shadowColor = UIColor.black.cgColor
        personView.layer.shadowOffset = CGSize(width: 3, height: 3)
        personView.layer.shadowOpacity = 0.7
        personView.layer.shadowRadius = 4.0
    }
}
