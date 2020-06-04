//
//  ViewController.swift
//  iOSFireBase
//
//  Created by Hoang Tung on 5/28/20.
//  Copyright © 2020 Hoang Tung. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
  
  var backgroundView: BackgroundView = {
    let view = BackgroundView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  var treeImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "TreeVector.png")
    imageView.backgroundColor = .clear
    return imageView
  }()
  
  var logoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "logo.png")
    imageView.backgroundColor = .clear
    return imageView
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
  
  var signupButton: CustomButton = {
    let button = CustomButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Sign Up", for: .normal)
    button.backgroundColor = UIColor.init(red: 171/255, green: 95/255, blue: 208/255, alpha: 1)
    button.normalColor = UIColor.init(red: 171/255, green: 95/255, blue: 208/255, alpha: 1)
    button.highlightedColor = UIColor.init(red: 154/255, green: 43/255, blue: 208/255, alpha: 1)
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
    // Do any additional setup after loading the view.
    view.backgroundColor = UIColor.white
    
    setupNavigationBar()
    addComponent()
    setupLayout()
    setupButton()
  }
  
  func setupNavigationBar() {
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.isTranslucent = true
    navigationController?.view.backgroundColor = .clear
  }

  func addComponent() {
    view.addSubview(backgroundView)
    view.addSubview(treeImageView)
    view.addSubview(logoImageView)
    view.addSubview(loginButton)
    view.addSubview(signupButton)
    view.addSubview(footerView)
    footerView.addSubview(footerImageView)
  }
  
  func setupLayout() {
    backgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
    backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
    backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    
    treeImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
    treeImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
    treeImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
    treeImageView.heightAnchor.constraint(equalToConstant: 272).isActive = true
    
    logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    logoImageView.topAnchor.constraint(equalTo: treeImageView.bottomAnchor, constant: -70).isActive = true
    logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33).isActive = true
    logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor, multiplier: 1.16).isActive = true
    
    loginButton.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50).isActive = true
    loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 12).isActive = true
    signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    signupButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    signupButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    footerView.topAnchor.constraint(equalTo: signupButton.bottomAnchor, constant: 0).isActive = true
    footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
    footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    
    footerImageView.centerXAnchor.constraint(equalTo: footerView.centerXAnchor).isActive = true
    footerImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2).isActive = true
    footerImageView.heightAnchor.constraint(equalTo: footerImageView.widthAnchor, multiplier: 0.8).isActive = true
    footerImageView.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
  }
  
  func setupButton() {
    loginButton.addTarget(self, action: #selector(routeToLoginVC), for: .touchUpInside)
    signupButton.addTarget(self, action: #selector(routeToSignUpVC), for: .touchUpInside)
  }
  
  @objc func routeToLoginVC() {
    let destinationVC = LoginViewController()
    navigationController?.pushViewController(destinationVC, animated: true)
  }
  
  @objc func routeToSignUpVC() {
    let destinationVC = SignUpViewController()
    navigationController?.pushViewController(destinationVC, animated: true)
  }
}

