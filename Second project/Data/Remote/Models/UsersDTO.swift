//
//  UsersDTO.swift
//  Second project
//
//  Created by Dev2 on 04/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation

struct UsersDTO: Codable {
    let users: Array<UserDTO>?
    let info: InfoDTO?
    
    private enum CodingKeys: String, CodingKey {
        case users = "results"
        case info
    }
    
    func fetchUsers(completion: ServiceCompletion ) {
        
    }
}
