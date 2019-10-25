//
//  FourthAddCell.swift
//  Second project
//
//  Created by Dev2 on 24/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class FourthAddCell: UITableViewCell {
    @IBOutlet weak var personView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    static var typeName: String {
        return String(describing: self)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // corner radius
        personView.layer.cornerRadius = 10
        
        // shadow
        personView.layer.shadowColor = UIColor.black.cgColor
        personView.layer.shadowOffset = CGSize(width: 3, height: 3)
        personView.layer.shadowOpacity = 0.7
        personView.layer.shadowRadius = 4.0
        // Initialization code
        
        let calendar = Calendar(identifier: .gregorian)
        let comps = DateComponents()
        let maxDate = calendar.date(byAdding: comps, to: Date())
        datePicker.maximumDate = maxDate
    }
}
