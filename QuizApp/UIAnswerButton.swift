//
//  UIAnswerButton.swift
//  QuizApp
//
//  Created by Alex Stophel on 8/2/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit

@IBDesignable class UIAnswerButton: UIButton {
  @IBInspectable var index: Int = 0

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    layer.cornerRadius = 10
  }

  // Not sure why I need this, but IB shows errors without it.
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
}