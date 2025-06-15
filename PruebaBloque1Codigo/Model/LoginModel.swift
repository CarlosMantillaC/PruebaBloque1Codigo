//
//  Login.swift
//  PruebaBloque1Codigo
//
//  Created by Gopenux on 9/06/25.
//

import Foundation


class LoginModel {
    private let validUser = User(name: "Admin", password: "1234")
    
    func validate(user: String, password: String) -> Bool {
        return user == validUser.name && password == validUser.password
    }
}
