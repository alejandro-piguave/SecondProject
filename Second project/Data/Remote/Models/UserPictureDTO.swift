//
//  UserPictureDTO.swift
//  Second project
//
//  Created by Dev2 on 04/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation

struct UserPictureDTO: Codable {
    let large, medium, thumbnail: String?
    
    init(large: String?, medium: String?, thumbnail: String?) {
        self.large = large
        self.medium = medium
        self.thumbnail = thumbnail
    }
}
