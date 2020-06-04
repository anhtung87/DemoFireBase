//
//  SignUpViewController.swift
//  iOSFireBase
//
//  Created by Hoang Tung on 5/31/20.
//  Copyright © 2020 Hoang Tung. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {
  
  var backgroundView: BackgroundView = {
    let view = BackgroundView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  var logoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "logo.png")
    imageView.backgroundColor = .clear
    return imageView
  }()
  
  var fullNameTextField: CustomTextField = {
    let textField = CustomTextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.customLabel.text = "Full name"
    return textField
  }()
  
  var emailTextField: CustomTextField = {
    let textField = CustomTextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.customLabel.text = "E-mail"
    return textField
  }()
  
  var passwordTextField: CustomTextField = {
    let textField = CustomTextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.customLabel.text = "Password"
    textField.isSecureTextEntry = true
    return textField
  }()
  
  var confirmTextField: CustomTextField = {
    let textField = CustomTextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.customLabel.text = "Confirm password"
    textField.isSecureTextEntry = true
    return textField
  }()
  
  var signUpButton: CustomButton = {
    let button = CustomButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Sign Up", for: .normal)
    button.backgroundColor = UIColor.init(red: 171/255, green: 95/255, blue: 208/255, alpha: 1)
    button.normalColor = UIColor.init(red: 171/255, green: 95/255, blue: 208/255, alpha: 1)
    button.highlightedColor = UIColor.init(red: 154/255, green: 43/255, blue: 208/255, alpha: 1)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupSubView()
    setupLayout()
    setupButton()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupNavigationBar()
  }
  
  func setupNavigationBar() {
    let closeView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
    let closeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
    closeButton.setImage(UIImage(named: "close-btn.png"), for: . normal)
    closeView.addSubview(closeButton)
    closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
    let closeBtn = UIBarButtonItem(customView: closeView)
    navigationItem.hidesBackButton = true
    navigationItem.leftBarButtonItem = closeBtn
  }
  
  @objc func close() {
    navigationController?.popViewController(animated: true)
  }
  
  func setupSubView() {
    view.addSubview(backgroundView)
    view.addSubview(logoImageView)
    view.addSubview(fullNameTextField)
    view.addSubview(emailTextField)
    view.addSubview(passwordTextField)
    view.addSubview(confirmTextField)
    view.addSubview(signUpButton)
  }
  
  func setupLayout() {
    backgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
    backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
    backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    
    logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -UIScreen.main.bounds.height / 4).isActive = true
    logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33).isActive = true
    logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor, multiplier: 1.16).isActive = true
    
    fullNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 38).isActive = true
    fullNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    fullNameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.77).isActive = true
    fullNameTextField.heightAnchor.constraint(equalToConstant: 28).isActive = true
    
    emailTextField.topAnchor.constraint(equalTo: fullNameTextField.bottomAnchor, constant: 38).isActive = true
    emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.77).isActive = true
    emailTextField.heightAnchor.constraint(equalToConstant: 28).isActive = true
    
    passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 38).isActive = true
    passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.77).isActive = true
    passwordTextField.heightAnchor.constraint(equalToConstant: 28).isActive = true
    
    confirmTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 38).isActive = true
    confirmTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    confirmTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.77).isActive = true
    confirmTextField.heightAnchor.constraint(equalToConstant: 28).isActive = true
    
    signUpButton.topAnchor.constraint(equalTo: confirmTextField.bottomAnchor, constant: 50).isActive = true
    signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    signUpButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.46).isActive = true
    signUpButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
  }
  
  func setupButton() {
    signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
  }
  
  @objc func signUp() {
    if let fullname = fullNameTextField.text, let email = emailTextField.text, let password = passwordTextField.text, let confirm = confirmTextField.text {
      if password == confirm {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
          guard let user = authResult?.user, error == nil else{
            print("error \(error?.localizedDescription)")
            return
          }
          print(user)
        }
      }
    }
  }
}
