//
//  Login.swift
//  PruebaBloque1Codigo
//
//  Created by Gopenux on 9/06/25.
//

import Foundation


struct Usuario {
    
    let nombre: String
    let contrasena: String
}

class LoginModel {
    private let usuarioValido = Usuario(nombre: "Admin", contrasena: "1234")
    
    func validar(usuario: String, contrasena: String) -> Bool {
        return usuario == usuarioValido.nombre && contrasena == usuarioValido.contrasena
    }
}
