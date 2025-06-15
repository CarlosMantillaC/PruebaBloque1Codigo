//
//  LoginPresenter.swift
//  PruebaBloque1Codigo
//
//  Created by Gopenux on 9/06/25.
//

import Foundation

protocol LoginView: AnyObject {
    
    func showError()
    func navigatePlayer()
    
}

class LoginPresenter {
    weak var view: LoginView?
    private let model: LoginModel
    
    init(view: LoginView, model: LoginModel = LoginModel()) {
        self.view = view
        self.model = model
    }
    
    func login(user: String, password: String) {
        if model.validate(user: user, password: password) {
            view?.navigatePlayer()
        } else {
            view?.showError()
        }
    }
}
