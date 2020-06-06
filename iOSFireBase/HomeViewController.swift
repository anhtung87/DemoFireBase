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
  
  let cellSpacing: CGFloat = 40
  let cellPeeking: CGFloat = 20
  var currentScrollOffset: CGPoint?
  let scrollThreshold: CGFloat = 10
  var itemWidth: CGFloat?
  var adjacentItemIndex = 0
  
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
    setupCollectionView()
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
    view.addSubview(contentCollectionView)
  }
  
  func setupLayout() {
    backgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
    backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
    backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    
    contentCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    contentCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    contentCollectionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 3 * 2).isActive = true
    contentCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
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
  
  func setupCollectionView() {
    contentCollectionView.delegate = self
    contentCollectionView.dataSource = self
    
    if let flowLayout = contentCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      flowLayout.scrollDirection = .horizontal
    }
    
    //    contentCollectionView.isPagingEnabled = true
    
    contentCollectionView.showsHorizontalScrollIndicator = false
  }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return Int(scrollThreshold)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCell", for: indexPath) as! ContentCollectionViewCell
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    itemWidth = max(0, collectionView.frame.size.width - 2 * (cellSpacing + cellPeeking))
    return CGSize(width: itemWidth!, height: collectionView.frame.size.height / 3 * 2)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return cellSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    let leftAndRightInsets = cellSpacing + cellPeeking
    return UIEdgeInsets(top: 0, left: leftAndRightInsets, bottom: 0, right: leftAndRightInsets)
  }
  
  public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    currentScrollOffset = scrollView.contentOffset
  }
  
  public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let target = targetContentOffset.pointee
    
    print(targetContentOffset.pointee)
    let screenIndex = CGFloat(Int(target.x/UIScreen.main.bounds.width))
    targetContentOffset.pointee = CGPoint(x: (itemWidth! + cellSpacing) * (screenIndex), y: target.y)
    print(targetContentOffset.pointee)
    print("=====")
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let visibleRect = CGRect(origin: contentCollectionView.contentOffset, size: contentCollectionView.frame.size)
    for cell in contentCollectionView.visibleCells as! [ContentCollectionViewCell] where cell.frame.intersects(visibleRect) {
      let distance = visibleRect.midX - cell.frame.midX
      if distance.magnitude < 20 {
        UIView.animate(withDuration: 1, animations: {
          cell.heightConstraint?.constant = 400
          cell.layoutIfNeeded()
        })
      } else {
        UIView.animate(withDuration: 1, animations: {
          cell.heightConstraint?.constant = 200
          cell.layoutIfNeeded()
        })
      }
    }
  }
}
