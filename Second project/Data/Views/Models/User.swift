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
    let gender: String?
    let title: String?
    let firstName: String?
    let lastName: String?
    let birthdate: Date?
    let email: String?
    let phone: String?
    let cell: String?
    let country: String?
    let city: String?
    let streetName: String?
    let streetNumber: Int?
    let nationality: String?
    let longitude: Double?
    let latitude: Double?
    let img: String?
    
    var nameAndAge: String {
        return "\(firstName ?? ""), \(age)"
    }
    var fullName: String {
        return "\(firstName ?? "") \(lastName ?? "")"
    }
    var streetInfo: String {
        return "\(streetName ?? ""), \(streetNumber ?? 0)"
    }
    var dobInfo: String {
        return "🎂: \(dob) (\(age) years)"
    }
    var dob: String {
        guard let bd = birthdate else {
            return ""
            }
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM, yyyy"
        return dateFormatterPrint.string(from: bd)
    }
    var location: String {
        return "\(city ?? ""), \(country ?? "") \(flag)"
    }
    var age: Int {
        guard let bd = birthdate else {
            return 0
        }
        return Calendar.current.dateComponents([.year], from: bd, to: Date()).year ?? 0
    }
    
    var genderEmoji: String {
        switch gender {
        case "male":
            return "♂"
        case "female":
            return "♀"
        default:
            return ""
        }
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
    
    
    init(id: String,
         gender: String? = nil,
         title: String? = nil,
         firstName: String? = nil,
         lastName: String? = nil,
         birthdate: Date? = nil,
         email: String? = nil,
         phone: String? = nil,
         cell: String? = nil,
         country: String? = nil,
         city: String? = nil,
         streetName: String? = nil,
         streetNumber: Int? = nil,
         nationality: String? = nil,
         longitude: Double? = nil,
         latitude: Double? = nil,
         avatar: String? = nil) {
        self.id = id
        self.title = title
        self.gender = gender
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phone = phone
        self.cell = cell
        self.birthdate = birthdate
        self.country = country
        self.city = city
        self.streetName = streetName
        self.streetNumber = streetNumber
        self.nationality = nationality
        self.latitude = latitude
        self.longitude = longitude
        self.img = avatar
    }
}
