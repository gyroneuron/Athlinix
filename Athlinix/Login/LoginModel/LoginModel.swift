//
//  LoginModel.swift
//  Athlinix
//
//  Created by Vivek Jaglan on 12/17/24.
//

import Foundation


class LoginModel:Codable{
    
    var username: String?
    var password: String?
    
    init(username: String? = nil, password: String? = nil) {
        self.username = username
        self.password = password
    }
    
    }
