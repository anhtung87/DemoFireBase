//
//  CustomTextField.swift
//  iOSFireBase
//
//  Created by Hoang Tung on 5/31/20.
//  Copyright © 2020 Hoang Tung. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
  
  var customLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = ""
    label.textColor = UIColor.init(red: 245/255, green: 166/255, blue: 35/255, alpha: 1)
    label.font = .systemFont(ofSize: 14)
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.addSubview(customLabel)
    self.textColor = UIColor.init(red: 107/255, green: 83/255, blue: 195/255, alpha: 1)
    self.font = .systemFont(ofSize: 16)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    let bottomLine = CALayer()
    bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 1, width: self.frame.width, height: 1.0)
    bottomLine.backgroundColor = UIColor.init(red: 107/255, green: 83/255, blue: 195/255, alpha: 1).cgColor
    self.borderStyle = .none
    self.layer.addSublayer(bottomLine)
    
    customLabel.bottomAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
    customLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
    customLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    customLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
  }
  
}
