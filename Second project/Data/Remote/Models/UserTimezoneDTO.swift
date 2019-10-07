//
//  UserTimezoneDTO.swift
//  Second project
//
//  Created by Dev2 on 07/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation

struct UserTimezoneDTO: Codable {
    let offset, timezoneDescription: String
    
    enum CodingKeys: String, CodingKey {
        case offset
        case timezoneDescription = "description"
    }
}
