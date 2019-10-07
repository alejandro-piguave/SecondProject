//
//  UserDAO.swift
//  Second project
//
//  Created by Dev2 on 04/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import RealmSwift

class UserDAO: Object {
    @objc dynamic var gender: String = ""
    
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    
    @objc dynamic var country: String = ""
    
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    
    @objc dynamic var email: String = ""
    @objc dynamic var uuid: String = ""
    
    @objc dynamic var birthday: Date = Date()
    
    @objc dynamic var avatar: String = ""
}
