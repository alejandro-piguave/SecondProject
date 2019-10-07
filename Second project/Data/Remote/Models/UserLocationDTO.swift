//
//  UserLocationDTO.swift
//  Second project
//
//  Created by Dev2 on 04/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation

struct UserLocationDTO: Codable {
    let street: UserStreetDTO?
    let city, state, country: String?
    let postcode: Int?
    let coordinates: UserCoordinatesDTO?
    let timezone: UserTimezoneDTO?
    

}
