//
//  ViewController.swift
//  PruebaBloque1Codigo
//
//  Created by Gopenux on 5/06/25.
//

import UIKit

class LoginViewController: UIViewController {
    var loginPresenter: LoginPresenter?

    private let userLabel: UILabel = {
        let label = UILabel()
        label.text = "Usuario"
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let userTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Ingrese tu usuario"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Ingresa tu contraseña"
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let passwordTextField: UITextField = {
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
        
        let button = UIButton(type: .system, primaryAction: UIAction(handler: { [weak self] _ in self?.loginButtonTapped() }))
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
        
        loginPresenter = LoginPresenter(view: self)

        view.backgroundColor = .white
        
        [userLabel, userTextField, passwordLabel, passwordTextField, loginButton, registerButton].forEach(view.addSubview)
    
        NSLayoutConstraint.activate([
            userLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            userLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            userTextField.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: 8),
            userTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            passwordLabel.topAnchor.constraint(equalTo: userTextField.bottomAnchor, constant: 20),
            passwordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -50),
            
            registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            registerButton.leadingAnchor.constraint(equalTo: loginButton.trailingAnchor, constant: 30)
        ])
    }
}
    
extension LoginViewController {
    func loginButtonTapped() {
        let user = userTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        loginPresenter?.login(user: user, password: password)
    }
}

extension LoginViewController: LoginView {
    func showError() {
        let alert = UIAlertController(title: "Error", message: "Credenciales Incorrectas", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func navigatePlayer() {
        self.navigationController?.pushViewController(ReproductiveViewController(), animated: true)
    }
}
