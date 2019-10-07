//
//  DatabaseManager.swift
//  Second project
//
//  Created by Dev2 on 07/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseManager {
    static let shared = DatabaseManager()
    
    private init() {}
    
    private let realm = try! Realm()
    
    
    func save(user: UserDAO) {
        try! realm.write {
            realm.add(user, update: .modified)
        }
    }
    
    
    func delete(user: UserDAO) {
        try! realm.write {
            realm.delete(user)
        }
    }
    
    func delete(id: String) {
        guard let user = realm.object(ofType: UserDAO.self, forPrimaryKey: id) else {
            return
        }
        
        try! realm.write {
            realm.delete(user)
        }
    }
    
    func loadUsers() -> Results<UserDAO> {
        return realm.objects(UserDAO.self)
    }
    
    func loadUser(id: String) -> UserDAO? {
        return realm.objects(UserDAO.self).filter("uuid == %@", id).first
    }
    
    func deleteAll() {
        try! realm.write {
            realm.deleteAll()
        }
    }
}
