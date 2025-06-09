//
//  LoginPresenter.swift
//  PruebaBloque1Codigo
//
//  Created by Gopenux on 9/06/25.
//

import Foundation

protocol LoginView: AnyObject {
    
    func mostrarError(_ mensaje: String)
    func navegarAlReproductor()
    
}

class LoginPresenter {
    weak var view: LoginView?
    private let usuarioValido = "Admin"
    private let contrasenaValida = "1234"
    
    init(view: LoginView) {
        self.view = view
    }
    
    func login(usuario: String, contrasena: String) {
        if usuario == usuarioValido && contrasena == contrasenaValida {
            view?.navegarAlReproductor()
        } else {
            view?.mostrarError("Credenciales Incorrectas")
        }
    }
}

