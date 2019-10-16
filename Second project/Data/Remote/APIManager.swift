//
//  APIManager.swift
//  Second project
//
//  Created by Dev2 on 07/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation
import Alamofire

enum ServiceResult {
    case success(data: Any?)
    case failure(msg: String)
}

typealias ServiceCompletion = (_ result: ServiceResult) -> Void

class APIManager {
    static let shared = APIManager()
    private init() {}
    
    func fetchUsers(num: Int, completion: @escaping ServiceCompletion) {
        Alamofire.request("https://randomuser.me/api?results=\(num)")
            .responseJSON { response in
                guard response.error == nil, let responseData = response.data else {
                    completion(.failure(msg: "Error en la peticion al servicio"))
                    return
                }
                do {
                    
                    let item = try JSONDecoder().decode(UsersDTO.self, from: responseData)
                    completion(.success(data: item))
                }catch {
                    completion(.failure(msg: "Error parsing JSON object."))
                }
        }
        
    }
    
}

