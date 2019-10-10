//
//  UserLocationDTO.swift
//  Second project
//
//  Created by Dev2 on 04/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation

struct UserLocationDTO {
    let street: UserStreetDTO?
    let city, state, country: String?
    let postcode: String?
    let coordinates: UserCoordinatesDTO?
    let timezone: UserTimezoneDTO?
    
    enum CodingKeys: String, CodingKey {
        case street, city, state, country = "country", postcode, coordinates, timezone
    }
}

extension UserLocationDTO: Codable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        var temp = ""
        do {
            temp = try values.decode(String.self, forKey: .postcode)
        } catch {
            temp = String(try values.decode(Int.self, forKey: .postcode))
        }
        postcode = temp
        street = try values.decode(UserStreetDTO.self, forKey: .street)
        city = try values.decode(String.self, forKey: .city)
        state = try values.decode(String.self, forKey: .state)
        do {
            country = try values.decode(String.self, forKey: .country)
        } catch {
            country = ""
        }
        coordinates = try values.decode(UserCoordinatesDTO.self, forKey: .coordinates)
        timezone = try values.decode(UserTimezoneDTO.self, forKey: .timezone)
    }
}
