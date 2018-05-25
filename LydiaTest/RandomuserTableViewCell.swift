//
//  RandomuserTableViewCell.swift
//  LydiaTest
//
//  Created by Maxime Bertaux on 23/05/2018.
//  Copyright © 2018 Maxime Bertaux. All rights reserved.
//

import UIKit
import SnapKit

class RandomuserTableViewCell: UITableViewCell {
    var container = UIView()
    var firstNameLabel = UILabel()
    var lastNameLabel = UILabel()
    var emailLabel = UILabel()
    var infoButton = UIButton()
    var customBlack = UIColor()
    var customGrey = UIColor()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        customBlack = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        customGrey = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
        
        cellViewsSetup()
        cellConstraintsSetup()
        cellDesignSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func cellViewsSetup() {
        contentView.addSubview(container)
        container.addSubview(firstNameLabel)
        container.addSubview(lastNameLabel)
        container.addSubview(emailLabel)
    }
    
    func cellConstraintsSetup() {
        container.snp.makeConstraints{(make) -> Void in
            make.top.bottom.left.right.equalTo(contentView)
        }
        firstNameLabel.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(container).offset(20)
            make.left.equalTo(container).offset(20)
        }
        lastNameLabel.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(container).offset(20)
            make.left.equalTo(firstNameLabel.snp.right).offset(3)
        }
        emailLabel.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(firstNameLabel.snp.bottom).offset(5)
            make.left.equalTo(container).offset(20)
        }
    }
    
    func cellDesignSetup() {
        firstNameLabel.font = UIFont(name: "Montserrat-Regular", size: (firstNameLabel.font?.pointSize)!)
        lastNameLabel.font = UIFont(name: "Montserrat-Regular", size: (lastNameLabel.font?.pointSize)!)
        emailLabel.font = UIFont(name: "Montserrat-Regular", size: (emailLabel.font?.pointSize)!-5)
        
        firstNameLabel.textColor = customBlack
        lastNameLabel.textColor = customBlack
        emailLabel.textColor = customGrey
    }
}
