//
//  UserLoginDTO+.swift
//  Second project
//
//  Created by Dev2 on 04/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation

struct UserLoginDTO: Codable {
    let uuid, username, password, salt: String?
    let md5, sha1, sha256: String?
    
}
