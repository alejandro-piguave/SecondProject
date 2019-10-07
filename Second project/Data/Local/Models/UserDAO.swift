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
    
    @objc dynamic var firstName: String?
    @objc dynamic var lastName: String?
    
    @objc dynamic var country: String?
    
    @objc dynamic var latitude: String?
    @objc dynamic var longitude: String?
    
    @objc dynamic var email: String?
    @objc dynamic var uuid: String?
    
    @objc dynamic var birthday: Date?
    
    @objc dynamic var avatar: String?
    
    convenience init(uuid: String,
         avatar: String? = nil,
         firstName: String? = nil,
         lastName: String? = nil,
         email: String? = nil,
         gender: String? = nil,
         birthdate: Date? = nil,
         country: String? = nil,
         latitude: String? = nil,
         longitude: String? = nil) {
        
        self.init()
        self.avatar = avatar
        self.firstName = lastName
        self.country = country
        self.email = email
        self.birthday = birthdate
        self.uuid = uuid
        self.latitude = latitude
        self.longitude = longitude
        
    }
    
    override static func primaryKey() -> String? {
        return "uuid"
    }
}
