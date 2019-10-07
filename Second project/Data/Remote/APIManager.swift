//
//  APIManager.swift
//  Second project
//
//  Created by Dev2 on 07/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation

enum ServiceResult {
    case success(data: Any?)
    case failure(msg: String)
}

typealias ServiceCompletion = (_ result: ServiceResult) -> Void

class APIManager {
    static let shared = APIManager()
    private init() {}
    
    func fetchUsers(completion: ServiceCompletion) {
        
    }
}
