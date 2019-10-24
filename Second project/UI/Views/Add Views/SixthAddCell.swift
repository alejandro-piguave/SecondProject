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

    }
    @objc func textFieldDidChange() {
        if let l1 = latitudeTF.text, let l2 = longitudeTF.text, let latitude = Double(l1), let longitude = Double(l2) {
            let location = CLLocation(latitude: latitude,
                                      longitude: longitude)
            let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1_200_000, longitudinalMeters: 1_200_000)
            mapView.setRegion(coordinateRegion, animated: true)
            
            //let annotation = MKPointAnnotation()
            //annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            //mapView.addAnnotation(annotation)
        }
    }   
}
