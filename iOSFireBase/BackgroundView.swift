//
//  BackgroundView.swift
//  iOSFireBase
//
//  Created by Hoang Tung on 5/30/20.
//  Copyright © 2020 Hoang Tung. All rights reserved.
//

import UIKit

class BackgroundView: UIView {

  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    let gradient = CAGradientLayer()
    gradient.colors = [UIColor.white.cgColor, UIColor(red: 240/255, green: 236/255, blue: 230/255, alpha: 1.0).cgColor]
    gradient.locations = [0.0, 1.0]
    gradient.startPoint = CGPoint(x: 0.5, y: 0)
    gradient.endPoint = CGPoint(x: 0.5, y: 1)
    gradient.frame = self.bounds
    self.layer.addSublayer(gradient)
  }
  
}
