//
//  BaseView.swift
//  TopReddits
//
//  Created by Raphael Braun on 29/05/21.
//

import UIKit

class BaseView: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
  }

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.setup()
  }

  required public init() {
    super.init(frame: CGRect.zero)
    self.setup()
  }

  func initialize() {
    fatalError("Must be overridden")
  }

  func installConstraints() {
    fatalError("Must be overridden")
  }

  fileprivate func setup() {
    self.initialize()
    self.installConstraints()
  }
}

