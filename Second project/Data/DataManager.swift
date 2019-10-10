//
//  DataManager.swift
//  Second project
//
//  Created by Dev2 on 04/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation
import RealmSwift

class DataManager {
    static let shared = DataManager()
    var numUsers = 100
    private init() {}
    
    func loadUsers(completion:  @escaping ServiceCompletion) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let results = self?.loadUsersFromDB() else {
                completion(.failure(msg: "Error al cargar los usuarios."))
                return
            }
            if results.count > 0 {
                self?.postToMain(results: results, completion: completion)
            }else {
                self?.forceUpdateUsers(completion: completion)
            }
        }
    }
    func convert(from results: Results<UserDAO>) -> Array<User> {
        return Array(results).compactMap({convert(userDAO: $0)})
    }
    
    private func convert(userDAO: UserDAO) -> User {
        return User(id: userDAO.uuid, firstName: userDAO.firstName, lastName: userDAO.lastName, birthdate: userDAO.birthday, email: userDAO.email, country: userDAO.country, nationality: userDAO.nationality, avatar: userDAO.avatar)
    }
    
    func forceUpdateUsers(completion: @escaping ServiceCompletion) {
        DispatchQueue.global(qos: .background).async {
            APIManager.shared.fetchUsers(num: self.numUsers){ [weak self] result in
                switch result {
                case .success(let data):
                    guard let users = data as? UsersDTO else {
                        completion(.failure(msg: "Error al convertir a UsersDTO"))
                        return
                    }
                    DatabaseManager.shared.deleteAll()
                    self?.save(users: users)
                    
                    guard let results = self?.loadUsersFromDB() else {
                        return
                    }
                    self?.postToMain(results: results, completion: completion)
                case .failure(let msg):
                    
                    DispatchQueue.main.async {
                        completion(.failure(msg: "Error al solicitar los usuarios al servidor: \(msg)"))
                    }
                    return
                }
            }
        }
    }
    
    
    func user(id: String, completion: @escaping ServiceCompletion) {
        DispatchQueue.global(qos: .background).async {
            if let user = DatabaseManager.shared.loadUser(id: id) {
                DispatchQueue.main.async {
                    completion(.success(data: self.convert(userDAO: user)))
                }
            }else {
                DispatchQueue.main.async {
                    completion(.failure(msg: "No"))
                }
            }
        }
    }
    
    private func loadUsersFromDB() -> Results<UserDAO> {
        return DatabaseManager.shared.loadUsers()
    }
    
    private func save(users: UsersDTO) {
        guard let usersList = users.users else {
            return
        }
        usersList.forEach( {save(user: $0)} )
    }
    
    private func save(user: UserDTO) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        guard let userUUID = user.login?.uuid, let userDateString = user.dob?.date else {
            return
        }
        
        let localUser = UserDAO(uuid: userUUID,
                                avatar: user.picture?.large,
                                firstName: user.name?.first,
                                lastName: user.name?.last,
                                email: user.email,
                                gender: user.gender,
                                birthdate: dateFormatter.date(from: userDateString),
                                country: user.location?.country,
                                nationality: user.nat,
                                latitude: user.location?.coordinates?.latitude,
                                longitude: user.location?.coordinates?.longitude)
        
        DatabaseManager.shared.save(user: localUser)
    }
    
    private func postToMain(results: Results<UserDAO>, completion: @escaping ServiceCompletion) {
        let resultsRef = ThreadSafeReference(to: results)
        DispatchQueue.main.async {
            autoreleasepool{
                let realm = try! Realm()
                guard let users = realm.resolve(resultsRef) else {
                    completion(.failure(msg: "Error al obtener la referencia al objeto."))
                    return
                }
                completion(.success(data: users))
            }
        }
    }
    
}
