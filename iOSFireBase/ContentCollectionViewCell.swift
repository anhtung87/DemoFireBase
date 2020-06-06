//
//  ContentCollectionViewCell.swift
//  iOSFireBase
//
//  Created by Hoang Tung on 6/1/20.
//  Copyright © 2020 Hoang Tung. All rights reserved.
//

import UIKit

class ContentCollectionViewCell: UICollectionViewCell {
  
  var isTargeted: Bool = false
  var heightConstraint: NSLayoutConstraint?
  
  var customView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
  }()
  
  var smallView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.borderColor = UIColor.systemGreen.cgColor
    view.layer.borderWidth = 1
    view.backgroundColor = .systemPink
    return view
  }()
    
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.layer.borderColor = UIColor.systemRed.cgColor
    self.layer.borderWidth = 1
    
    setupSubView()
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupSubView() {
    self.addSubview(customView)
    self.addSubview(smallView)
  }
  
  func setupLayout() {
    customView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    customView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    customView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    customView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    
    smallView.leadingAnchor.constraint(equalTo: customView.leadingAnchor).isActive = true
    smallView.trailingAnchor.constraint(equalTo: customView.trailingAnchor).isActive = true
    smallView.bottomAnchor.constraint(equalTo: customView.bottomAnchor).isActive = true
    heightConstraint = smallView.heightAnchor.constraint(equalToConstant: 200)
    heightConstraint!.isActive = true
  }
}
