//
//  AppDelegate+Resolving.swift
//  AM5
//
//  Created by HoSeon Chu on 2023/02/01.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        register { AuthenticationService() }
        register { FireStoreTaskRepository() as TaskRepository }
    }
}


