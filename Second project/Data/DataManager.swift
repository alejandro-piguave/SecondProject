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
    
    private func convert(userDAO: UserDAO) -> User {
        return User(id: userDAO.uuid,
                    gender: userDAO.gender,
                    title: userDAO.title,
                    firstName: userDAO.firstName,
                    lastName: userDAO.lastName,
                    birthdate: userDAO.birthday,
                    email: userDAO.email,
                    phone: userDAO.phone,
                    cell: userDAO.cell,
                    country: userDAO.country,
                    city: userDAO.city,
                    streetName: userDAO.streetName,
                    streetNumber: userDAO.streetNumber.value,
                    nationality: userDAO.nationality,
                    longitude: userDAO.longitude.value,
                    latitude: userDAO.latitude.value,
                    avatar: userDAO.avatar)
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
    
    private func loadUsersFromDB() -> Array<User> {
        var data = Array(DatabaseManager.shared.loadUsers()).compactMap({convert(userDAO: $0)})
        data.sort { (user1, user2) -> Bool in
            guard let date1 = user1.birthdate, let date2 = user2.birthdate else {
                return false
            }
            return date1 > date2
        }
        return data
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
                                title: user.name?.title,
                                firstName: user.name?.first,
                                lastName: user.name?.last,
                                email: user.email,
                                phone: user.phone,
                                cell: user.cell,
                                gender: user.gender,
                                birthdate: dateFormatter.date(from: userDateString),
                                country: user.location?.country,
                                city: user.location?.city,
                                streetName: user.location?.street?.name,
                                streetNumber: user.location?.street?.number,
                                nationality: user.nat,
                                latitude: Double(user.location?.coordinates?.latitude ?? "0.0"),
                                longitude: Double(user.location?.coordinates?.longitude ?? "0.0"))
        
        DatabaseManager.shared.save(user: localUser)
    }
    
    private func postToMain(results: Array<User>, completion: @escaping ServiceCompletion) {
        DispatchQueue.main.async {
            autoreleasepool{
                completion(.success(data: results))
            }
        }
    }
    
}
