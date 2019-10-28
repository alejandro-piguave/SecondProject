//
//  FirstAddCell.swift
//  Second project
//
//  Created by Dev2 on 24/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class FirstAddCell: UITableViewCell {
    static var typeName: String {
        return String(describing: self)
    }
    @IBOutlet weak var personView: UIView!
    @IBOutlet weak var userIV: UIImageView!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    
    var onImageViewClicked: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()  
        // corner radius
        personView.layer.cornerRadius = 10
        
        // shadow
        personView.layer.shadowColor = UIColor.black.cgColor
        personView.layer.shadowOffset = CGSize(width: 3, height: 3)
        personView.layer.shadowOpacity = 0.7
        personView.layer.shadowRadius = 4.0
        
        userIV.layer.masksToBounds = false
        userIV.layer.cornerRadius = userIV.frame.height/2
        userIV.clipsToBounds = true
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(imageViewClicked))
        userIV.isUserInteractionEnabled = true
        userIV.addGestureRecognizer(singleTap)
    }
    
    func resetImage() {
        userIV.image = UIImage(named: "default-user-icon")
    }
    //Action
    @objc private func imageViewClicked() {
        onImageViewClicked?()
    }
}
