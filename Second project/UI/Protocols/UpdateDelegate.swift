//
//  DeleteDelegate.swift
//  Second project
//
//  Created by Dev2 on 22/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation

protocol UpdateDelegate: class {
    func onUserDeleted(user: User)
    func onUserAdded(user: User)
}
