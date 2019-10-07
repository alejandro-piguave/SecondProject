//
//  UserCoordinatesDTO.swift
//  Second project
//
//  Created by Dev2 on 07/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation


struct UserCoordinatesDTO: Codable {
    struct Coordinates: Codable {
        let latitude, longitude: String
    }

}
