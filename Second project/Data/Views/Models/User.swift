//
//  User.swift
//  Second project
//
//  Created by Dev2 on 08/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation

class User {
    let id: String
    let firstName: String?
    let lastName: String?
    let birthdate: Date?
    let email: String?
    let country: String?
    let nationality: String?
    let img: String?
    
    var name: String {
        return "\(firstName ?? "") \(lastName ?? "")"
    }
    
    var age: Int {
        guard let bd = birthdate else {
            return 0
        }
        return Calendar.current.dateComponents([.year], from: bd, to: Date()).year ?? 0
    }
    
    
    init(id: String, firstName: String? = nil, lastName: String? = nil, birthdate: Date? = nil, email: String? = nil, country: String? = nil, nationality: String? = nil,
                     avatar: String? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.birthdate = birthdate
        self.country = country
        self.nationality = nationality
        self.img = avatar
        
    }
}
