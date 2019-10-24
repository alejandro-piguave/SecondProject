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
        // Initialization code
    }
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
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(from user: User) {
        if let l1 = user.latitude, let l2 = user.longitude, let latitude = Double(l1), let longitude = Double(l2) {
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
