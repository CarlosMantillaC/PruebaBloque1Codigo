//
//  ViewController.swift
//  PruebaBloque1Codigo
//
//  Created by Gopenux on 5/06/25.
//

import UIKit

class ViewController: UIViewController {

    let usuarioValido = "Admin"
    let contrasenaValida = "1234"
    
    private let usuarioLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Usuario"
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private let usuarioTextField: UITextField = {
        
        let textField = UITextField()
        textField.placeholder = "Ingrese tu usuario"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
        
    }()
    
    private let contrasenaLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Ingresa tu contraseña"
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    
    private let contrasenaTextField: UITextField = {
        
        let textField = UITextField()
        textField.placeholder = "Ingresa tu contraseña"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
        
    }()
    
    
    private lazy var loginButton: UIButton = {
            
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Login"
        configuration.titleAlignment = .center
        
        let button = UIButton(type: .system, primaryAction: UIAction(handler: { _ in self.login() }))
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    
    private lazy var registerButton: UIButton = {
        
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Registar"
        configuration.titleAlignment = .center
        
        let button = UIButton(type: .system)
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        [usuarioLabel, usuarioTextField, contrasenaLabel, contrasenaTextField, loginButton, registerButton].forEach(view.addSubview)
    

        NSLayoutConstraint.activate([
            usuarioLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            usuarioLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            usuarioTextField.topAnchor.constraint(equalTo: usuarioLabel.bottomAnchor, constant: 8),
            usuarioTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            contrasenaLabel.topAnchor.constraint(equalTo: usuarioTextField.bottomAnchor, constant: 20),
            contrasenaLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            contrasenaTextField.topAnchor.constraint(equalTo: contrasenaLabel.bottomAnchor, constant: 8),
            contrasenaTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            loginButton.topAnchor.constraint(equalTo: contrasenaTextField.bottomAnchor, constant: 30),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -50),
            
            registerButton.topAnchor.constraint(equalTo: contrasenaTextField.bottomAnchor, constant: 30),
            registerButton.leadingAnchor.constraint(equalTo: loginButton.trailingAnchor, constant: 30)
        ])
    }


    @objc private func login() {
        let usuario = usuarioTextField.text ?? ""
        let contrasena = contrasenaTextField.text ?? ""
        
        if usuario == usuarioValido && contrasena == contrasenaValida {
            
            self.navigationController?.pushViewController(ViewControllerReproductor(), animated: true)

        } else {
            let alerta = UIAlertController(title: "Error", message: "Credenciales Incorrectas", preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "OK", style: .default))
            present(alerta, animated: true)
        }
    }
    
    
}
