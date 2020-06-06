//
//  LoginViewController.swift
//  iOSFireBase
//
//  Created by Hoang Tung on 5/31/20.
//  Copyright © 2020 Hoang Tung. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
  
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
  
  var usernameTextField: CustomTextField = {
    let textField = CustomTextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.customLabel.text = "E-Mail"
    return textField
  }()
  
  var passwordTextField: CustomTextField = {
    let textField = CustomTextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.customLabel.text = "Password"
    textField.isSecureTextEntry = true
    return textField
  }()
  
  var loginButton: CustomButton = {
    let button = CustomButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Login", for: .normal)
    button.backgroundColor = UIColor.init(red: 107/255, green: 83/255, blue: 195/255, alpha: 1)
    button.normalColor = UIColor.init(red: 107/255, green: 83/255, blue: 195/255, alpha: 1)
    button.highlightedColor = UIColor.init(red: 80/255, green: 47/255, blue: 198/255, alpha: 1)
    return button
  }()
  
  var footerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  var footerImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "footer.png")
    imageView.backgroundColor = .clear
    return imageView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    // Do any additional setup after loading the view.
//    setupNavigationBar()
    setupSubView()
    setupLayout()
    setupButton()
    
    self.navigationItem.setHidesBackButton(true, animated: true);
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
    navigationItem.leftBarButtonItem = closeBtn
  }
  
  @objc func close() {
    navigationController?.popViewController(animated: true)
  }
  
  func setupSubView() {
    view.addSubview(backgroundView)
    view.addSubview(logoImageView)
    view.addSubview(usernameTextField)
    view.addSubview(passwordTextField)
    view.addSubview(loginButton)
    view.addSubview(footerView)
    footerView.addSubview(footerImageView)
  }
  
  func setupLayout() {
    backgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
    backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
    backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    
    logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -UIScreen.main.bounds.height / 6).isActive = true
    logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33).isActive = true
    logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor, multiplier: 1.16).isActive = true
    
    usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 56).isActive = true
    usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    usernameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.77).isActive = true
    usernameTextField.heightAnchor.constraint(equalToConstant: 28).isActive = true
    
    passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 38).isActive = true
    passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.77).isActive = true
    passwordTextField.heightAnchor.constraint(equalToConstant: 28).isActive = true
    
    loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 33).isActive = true
    loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.46).isActive = true
    loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    
    footerView.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 0).isActive = true
    footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
    footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    
    footerImageView.centerXAnchor.constraint(equalTo: footerView.centerXAnchor).isActive = true
    footerImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2).isActive = true
    footerImageView.heightAnchor.constraint(equalTo: footerImageView.widthAnchor, multiplier: 0.8).isActive = true
    footerImageView.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
  }
  
  func setupButton() {
    loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
  }
  
  @objc func login() {
    if let username = usernameTextField.text, let password = passwordTextField.text {
      Auth.auth().signIn(withEmail: username, password: password) { [weak self] authResult, error in
        guard let strongSelf = self else { return }
        if let user = authResult?.user {
          let destinationVC = HomeViewController()
          strongSelf.navigationController?.pushViewController(destinationVC, animated: true)
        } else {
          print(error)
        }
      }
    }
  }
}
