//
//  UserDTO.swift
//  Second project
//
//  Created by Dev2 on 04/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation

struct UserDTO: Codable {
    let gender: String?
    let name: UserNameDTO?
    let location: UserLocationDTO?
    let email: String?
    let login: UserLoginDTO?
    let dob, registered: UserDobDTO?
    let phone, cell: String?
    //let id: UserIDDTO?
    let picture: UserPictureDTO?
    let nat: String?
    
}
