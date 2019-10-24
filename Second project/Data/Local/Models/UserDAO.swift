//
//  UserDAO.swift
//  Second project
//
//  Created by Dev2 on 04/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import RealmSwift

class UserDAO: Object {
    @objc dynamic var gender: String?
    
    @objc dynamic var title: String?
    @objc dynamic var firstName: String?
    @objc dynamic var lastName: String?
    
    @objc dynamic var country: String?
    @objc dynamic var city: String?
    @objc dynamic var streetName: String?
    let streetNumber = RealmOptional<Int>()
    @objc dynamic var nationality: String?
    
    @objc dynamic var latitude: String?
    @objc dynamic var longitude: String?
    
    @objc dynamic var email: String?
    @objc dynamic var phone: String?
    @objc dynamic var cell: String?
    @objc dynamic var uuid: String = ""
    
    @objc dynamic var birthday: Date?
    
    @objc dynamic var avatar: String?
    
    convenience init(uuid: String,
         avatar: String? = nil,
         title: String? = nil,
         firstName: String? = nil,
         lastName: String? = nil,
         email: String? = nil,
         phone: String? = nil,
         cell: String? = nil,
         gender: String? = nil,
         birthdate: Date? = nil,
         country: String? = nil,
         city: String? = nil,
         streetName: String? = nil,
         streetNumber: Int? = nil,
         nationality: String? = nil,
         latitude: String? = nil,
         longitude: String? = nil) {
        
        self.init()
        self.uuid = uuid
        self.gender = gender
        self.nationality = nationality
        self.avatar = avatar
        self.title = title
        self.firstName = firstName
        self.lastName = lastName
        self.country = country
        self.city = city
        self.streetName = streetName
        self.streetNumber.value = streetNumber
        self.email = email
        self.phone = phone
        self.cell = cell
        self.birthday = birthdate
        self.latitude = latitude
        self.longitude = longitude
    }
    
    override static func primaryKey() -> String? {
        return "uuid"
    }
}
