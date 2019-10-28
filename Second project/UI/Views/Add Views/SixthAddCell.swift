//
//  SixthAddCell.swift
//  Second project
//
//  Created by Dev2 on 24/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit
import MapKit

class SixthAddCell: UITableViewCell {
    static var typeName: String {
        return String(describing: self)
    }
    

    @IBOutlet weak var personView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var latitudeTF: UITextField!
    @IBOutlet weak var longitudeTF: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        personView.layer.cornerRadius = 10
        
        // shadow
        personView.layer.shadowColor = UIColor.black.cgColor
        personView.layer.shadowOffset = CGSize(width: 3, height: 3)
        personView.layer.shadowOpacity = 0.7
        personView.layer.shadowRadius = 4.0
        // Initialization code
        
        latitudeTF.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        longitudeTF.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        
        latitudeTF.delegate = self
        //latitudeTF.keyboardType = .numberPad
        
        longitudeTF.delegate = self
        //longitudeTF.keyboardType = .numberPad
    }
    @objc func textFieldDidChange() {
        if let l1 = latitudeTF.text, let l2 = longitudeTF.text, let latitude = Double(l1), let longitude = Double(l2) {
            let location = CLLocation(latitude: latitude,
                                      longitude: longitude)
            let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1_100_000, longitudinalMeters: 1_100_000)
            mapView.setRegion(coordinateRegion, animated: true)
            
            //let annotation = MKPointAnnotation()
            //annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            //mapView.addAnnotation(annotation)
        }
    }   
}
extension SixthAddCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "-.0123456789").inverted
        
  
        
        if string.rangeOfCharacter(from: invalidCharacters) == nil {
            
            if let text = textField.text,
                let textRange = Range(range, in: text),
                let number = Double(text.replacingCharacters(in: textRange, with: string)){
                
                switch textField.tag {
                 case 0 where number > -90 && number < 90:
                     return true
                 case 1 where number > -180 && number < 180:
                     return true
                 default: return false
                 }
            } else {
                return true
            }
  
        }else {
            return false
        }
    }
}
