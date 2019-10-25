//
//  FourthTableViewCell.swift
//  Second project
//
//  Created by Dev2 on 18/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit
import MapKit

class FourthTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // corner radius
        personView.layer.cornerRadius = 10
        
        // shadow
        personView.layer.shadowColor = UIColor.black.cgColor
        personView.layer.shadowOffset = CGSize(width: 3, height: 3)
        personView.layer.shadowOpacity = 0.7
        personView.layer.shadowRadius = 4.0
    }
    @IBOutlet weak var personView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    func configure(from user: User) {
        if let latitude = user.latitude, let longitude = user.longitude {
            let location = CLLocation(latitude: latitude,
                                       longitude: longitude)
            let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1_500_000, longitudinalMeters: 1_500_000)
            mapView.setRegion(coordinateRegion, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            mapView.addAnnotation(annotation)
        } 
    }
}
extension FourthTableViewCell: MKMapViewDelegate {
        
}
