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
    private let model: LoginModel
    
    init(view: LoginView, model: LoginModel = LoginModel()) {
        self.view = view
        self.model = model
    }
    
    func login(usuario: String, contrasena: String) {
        if model.validar(usuario: usuario, contrasena: contrasena) {
            view?.navegarAlReproductor()
        } else {
            view?.mostrarError("Credenciales Incorrectas")
        }
    }
}
