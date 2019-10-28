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
    
    func save(user: UserDAO) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(user, update: .modified)
        }
        
    }
    func save(image: UIImage, forKey key: String) {
        if let pngRepresentation = image.pngData() {
            UserDefaults.standard.set(pngRepresentation, forKey: key)
        }
    }
    func loadImage(forKey key: String, completion: ServiceCompletion) {
        DispatchQueue.global(qos: .background).async {
            if let imageData = UserDefaults.standard.object(forKey: key) as? Data,
                let image = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    completion(.success(data: image))
                }
            }else {
                completion(.failure(msg: "Couldn't retrieve image."))
            }
        }

    }
    func delete(user: UserDAO) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(user)
        }
    }
    
    func delete(id: String) {
        let realm = try! Realm()
        guard let user = realm.object(ofType: UserDAO.self, forPrimaryKey: id) else {
            return
        }
        
        try! realm.write {
            realm.delete(user)
        }
    }
    
    func loadUsers() -> Results<UserDAO> {
        let realm = try! Realm()
        return realm.objects(UserDAO.self)
    }
    
    func loadUser(id: String) -> UserDAO? {
        let realm = try! Realm()
        return realm.object(ofType: UserDAO.self,forPrimaryKey: id)
    }
    
    func deleteAll() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    

}

