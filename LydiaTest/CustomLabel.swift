//
//  CustomLabel.swift
//  LydiaTest
//
//  Created by Maxime Bertaux on 24/05/2018.
//  Copyright © 2018 Maxime Bertaux. All rights reserved.
//

import UIKit
import SnapKit

class CustomLabel:UILabel {
    var anchor: ConstraintItem?
    var offset: Int?
    
    convenience init(_content: String?, _offset: Int?, _anchor: ConstraintItem, _font: UIFont) {
        self.init(frame: CGRect.zero)
        self.text = _content
        self.font = _font
        anchor = _anchor
        offset = _offset
    }
    
    func setupConstraint(_view: UIView) {
        self.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(anchor!).offset(offset!)
            make.centerX.equalTo(_view)
        }
    }
}
