//
//  PersonViewCell.swift
//  Second project
//
//  Created by Dev2 on 03/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit
import Kingfisher

class PersonTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // corner radius
        personView.layer.cornerRadius = 10
        
        // shadow
        personView.layer.shadowColor = UIColor.black.cgColor
        personView.layer.shadowOffset = CGSize(width: 3, height: 3)
        personView.layer.shadowOpacity = 0.7
        personView.layer.shadowRadius = 4.0
        
        personImage.layer.masksToBounds = false
        personImage.layer.cornerRadius = personImage.frame.height/2
        personImage.clipsToBounds = true
    }
    
    @IBOutlet weak var personView: UIView!
    
    @IBOutlet weak var personImage: UIImageView!
    
    
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var personMailLabel: UILabel!
    @IBOutlet weak var personNationality: UILabel!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        personImage.image = nil
        personMailLabel.text = nil
        personNameLabel.text = nil
        personNationality.text = nil
    }
    
    func configure(from user: User) {
        configureUserImage(imageLocation: user.img)
        personNameLabel.text = user.nameAndAge
        personMailLabel.text = user.email
        personNationality.text = user.flag
    }
}
extension PersonTableViewCell {
    private func configureUserImage(imageLocation: String?) {
        if let userImg = imageLocation {
            if let imageUUID = UUID(uuidString: userImg) {
                let imageUUIDString = imageUUID.uuidString
                DatabaseManager.shared.loadImage(forKey: imageUUIDString) { (result) in
                    switch result{
                    case .success(let data):
                        if let retrievedImage = data as? UIImage {
                            personImage.image = retrievedImage
                        }
                    default:
                        return
                    }
                }
            }else {
                let url = URL(string: userImg)
                personImage.kf.setImage(with: url)
            }
        } else {
            personImage.image = UIImage(named: "default-user-icon")
        }
    }
}
