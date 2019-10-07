//
//  DataManager.swift
//  Second project
//
//  Created by Dev2 on 04/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    private init() {}
    
    func users(completion: ServiceCompletion) {
        if usersDB().count > 0 {
            
        }else {
            forceUpdateUsers(completion: completion)
        }
    }
    
    func forceUpdateUsers(completion: ServiceCompletion) {
        APIManager.shared.fetchUsers(){ result in
            switch result {
            case .success(let data):
                guard let users = data as? UsersDTO else {
                    completion(.failure(msg: "Error genérico"))
                    return
                }
                DatabaseManager.shared.deleteAll()
                save(users: users)
                
                completion(.success(data: users))
            case .failure(_):
                completion(.failure(msg: "Error genérico"))
                return
            }
        }
    }
    
    func user(id: String) -> UserDAO? {
        return DatabaseManager.shared.loadUser(id: id)
    }
    
    private func usersDB() -> Array<UserDAO> {
        return Array(DatabaseManager.shared.loadUsers())
    }
    
    private func save(users: UsersDTO) {
        guard let usersList = users.users else {
            return
        }
        
        usersList.forEach( {save(user: $0)} )
    }
    
    private func save(user: UserDTO) {
        guard let userUUID = user.login?.uuid else {
            return
        }
        let localUser = UserDAO(uuid: userUUID, avatar: user.picture?.thumbnail, firstName: user.name?.first, lastName: user.name?.last, email: user.email, gender: user.gender, birthdate: user.dob?.date, country: user.location?.country, latitude: user.location?.coordinates?.latitude, longitude: user.location?.coordinates?.longitude)
        DatabaseManager.shared.save(user: localUser)
    }
}
