//
//  CountryDTO.swift
//  Second project
//
//  Created by Dev2 on 24/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation

struct CountryDTO: Codable {
    let code, name: String?
    enum CodingKeys: String, CodingKey {
        case code = "Code", name = "Name"
    }
}
