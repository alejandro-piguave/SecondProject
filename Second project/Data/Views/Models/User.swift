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
    let title: String?
    let firstName: String?
    let lastName: String?
    let birthdate: Date?
    let email: String?
    let country: String?
    let nationality: String?
    let img: String?
    
    var name: String {
        return "\(firstName ?? ""), \(age ?? 0)"
    }
    
    var age: Int? {
        guard let bd = birthdate else {
            return nil
        }
        return Calendar.current.dateComponents([.year], from: bd, to: Date()).year ?? 0
    }
    
    var flag: String {
        get {
            guard let nat = nationality else {
                return ""
            }
            let base : UInt32 = 127397
            var s = ""
            for v in nat.unicodeScalars {
                s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
            }
            return String(s)
        }
    }
    
    
    init(id: String, title: String? = nil, firstName: String? = nil, lastName: String? = nil, birthdate: Date? = nil, email: String? = nil, country: String? = nil, nationality: String? = nil,
                     avatar: String? = nil) {
        self.id = id
        self.title = title
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.birthdate = birthdate
        self.country = country
        self.nationality = nationality
        self.img = avatar
        
    }
}
