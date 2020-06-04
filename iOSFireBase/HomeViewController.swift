//
//  HomeViewController.swift
//  iOSFireBase
//
//  Created by Hoang Tung on 6/1/20.
//  Copyright © 2020 Hoang Tung. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class HomeViewController: UIViewController {
  
  var backgroundView: BackgroundView = {
    let view = BackgroundView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  var contentCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.layer.borderColor = UIColor.systemBlue.cgColor
    collectionView.layer.borderWidth = 0.5
    collectionView.backgroundView = UIView()
    collectionView.backgroundColor = .clear
    collectionView.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: "ContentCell")
    return collectionView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    setupNavigationBar()
    setupSubView()
    setupLayout()
  }
  
  func setupNavigationBar() {
    let closeView = UIView(frame: CGRect(x: 0, y: 0, width: 72, height: 24))
    let logoutButton = UIButton(frame: CGRect(x: 0, y: 0, width: 72, height: 24))
    logoutButton.setTitle("Log Out", for: .normal)
    logoutButton.setTitleColor(.white, for: .normal)
    logoutButton.titleLabel?.font = .systemFont(ofSize: 14)
    logoutButton.backgroundColor = UIColor.init(red: 171/255, green: 95/255, blue: 208/255, alpha: 1)
    logoutButton.layer.cornerRadius = 12
    closeView.addSubview(logoutButton)
    logoutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
    let logoutBtn = UIBarButtonItem(customView: closeView)
    navigationItem.rightBarButtonItem = logoutBtn
    navigationItem.hidesBackButton = true
  }
  
  func setupSubView() {
    view.addSubview(backgroundView)
    backgroundView.addSubview(contentCollectionView)
  }
  
  func setupLayout() {
    backgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
    backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
    backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    
    contentCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    contentCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    contentCollectionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2).isActive = true
    contentCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }
  
  @objc func logOut() {
    let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
      if Auth.auth().currentUser == nil {
        navigationController?.popToRootViewController(animated: true)
      }
    } catch let signOutError as NSError {
      print ("Error signing out: %@", signOutError)
    }
  }
}
