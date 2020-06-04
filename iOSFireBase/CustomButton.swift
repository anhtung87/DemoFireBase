//
//  PurpleButton.swift
//  iOSFireBase
//
//  Created by Hoang Tung on 5/30/20.
//  Copyright © 2020 Hoang Tung. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
  
  var normalColor: UIColor?
  var highlightedColor: UIColor?
  
  override open var isHighlighted: Bool {
    didSet {
      backgroundColor = isHighlighted ? highlightedColor : normalColor
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setTitle("login", for: .normal)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.setTitleColor(.white, for: .normal)
    self.layer.cornerRadius = self.frame.height / 2
    self.layer.shadowColor = UIColor.lightGray.cgColor
    self.layer.shadowOffset = CGSize(width: 0, height: 5)
    self.layer.shadowOpacity = 0.5
  }
}
