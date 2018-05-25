//
//  RandomuserInfoViewController.swift
//  LydiaTest
//
//  Created by Maxime Bertaux on 23/05/2018.
//  Copyright © 2018 Maxime Bertaux. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class RandomuserInfoViewController : UIViewController {
    var genderLabel = UILabel()
    var largepictureImageView = UIImageView()
    var mediumpictureImageView = UIImageView()
    var thumbnailImageView = UIImageView()
    var natLabel = UILabel()
    var labelDictionary:[Int:CustomLabel] = [:]
    var customFont = UIFont()
    var user : randomuser = randomuser(gender: "", name: names(title:"", first:"", last:""), location: location(street:"", city:"", state:"", postcode:0), email: "", login: logins(username : "", password : "", salt : "", md5 : "", sha1 : "", sha256 : ""), dob: "", registered: "", phone: "", cell: "", id: ids(name:"", value:""), picture: pictures(large : "", medium : "", thumbnail :""), nat: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = user.name.last
        customFont = UIFont(name: "Montserrat-Regular", size: 17)!
        labelDictionary[1] = CustomLabel(_content: user.gender, _offset: 100, _anchor: view.snp.top, _font: customFont)
        labelDictionary[2] = CustomLabel(_content: user.name.title, _offset: 5, _anchor: (labelDictionary[1]?.snp.bottom)!, _font: customFont)
        labelDictionary[3] = CustomLabel(_content: user.name.first, _offset: 5, _anchor: (labelDictionary[2]?.snp.bottom)!, _font: customFont)
        labelDictionary[4] = CustomLabel(_content: user.name.last, _offset: 5, _anchor: (labelDictionary[3]?.snp.bottom)!, _font: customFont)
        labelDictionary[5] = CustomLabel(_content: user.location.street, _offset: 5, _anchor: (labelDictionary[4]?.snp.bottom)!, _font: customFont)
        labelDictionary[6] = CustomLabel(_content: user.location.city, _offset: 5, _anchor: (labelDictionary[5]?.snp.bottom)!, _font: customFont)
        labelDictionary[7] = CustomLabel(_content: user.location.state, _offset: 5, _anchor: (labelDictionary[6]?.snp.bottom)!, _font: customFont)
        labelDictionary[8] = CustomLabel(_content: String(user.location.postcode), _offset: 5, _anchor: (labelDictionary[7]?.snp.bottom)!, _font: customFont)
        labelDictionary[9] = CustomLabel(_content: user.email, _offset: 5, _anchor: (labelDictionary[8]?.snp.bottom)!, _font: customFont)
        labelDictionary[10] = CustomLabel(_content: user.login.username, _offset: 5, _anchor: (labelDictionary[9]?.snp.bottom)!, _font: customFont)
        labelDictionary[11] = CustomLabel(_content: user.login.password, _offset: 5, _anchor: (labelDictionary[10]?.snp.bottom)!, _font: customFont)
        labelDictionary[12] = CustomLabel(_content: user.login.salt, _offset: 5, _anchor: (labelDictionary[11]?.snp.bottom)!, _font: customFont)
        labelDictionary[13] = CustomLabel(_content: user.login.md5, _offset: 5, _anchor: (labelDictionary[12]?.snp.bottom)!, _font: customFont)
        labelDictionary[14] = CustomLabel(_content: user.login.sha1, _offset: 5, _anchor: (labelDictionary[13]?.snp.bottom)!, _font: customFont)
        labelDictionary[15] = CustomLabel(_content: user.login.sha256, _offset: 5, _anchor: (labelDictionary[14]?.snp.bottom)!, _font: customFont)
        labelDictionary[16] = CustomLabel(_content: user.dob, _offset: 5, _anchor: (labelDictionary[15]?.snp.bottom)!, _font: customFont)
        labelDictionary[17] = CustomLabel(_content: user.registered, _offset: 5, _anchor: (labelDictionary[16]?.snp.bottom)!, _font: customFont)
        labelDictionary[18] = CustomLabel(_content: user.phone, _offset: 5, _anchor: (labelDictionary[17]?.snp.bottom)!, _font: customFont)
        labelDictionary[19] = CustomLabel(_content: user.cell, _offset: 5, _anchor: (labelDictionary[18]?.snp.bottom)!, _font: customFont)
        labelDictionary[20] = CustomLabel(_content: user.id.name, _offset: 5, _anchor: (labelDictionary[19]?.snp.bottom)!, _font: customFont)
        labelDictionary[21] = CustomLabel(_content: user.id.value, _offset: 5, _anchor: (labelDictionary[20]?.snp.bottom)!, _font: customFont)
        labelDictionary[22] = CustomLabel(_content: user.nat, _offset: 5, _anchor: (labelDictionary[21]?.snp.bottom)!, _font: customFont)
        
        setupView()
        setupImageViewCostraints()
        downloadPictures()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        let sortedKeys = Array(labelDictionary.keys).sorted(by: <)
        
        for key in sortedKeys {
            let value = labelDictionary[key]!
            
            self.view.addSubview(value)
            value.setupConstraint(_view: view)
        }
        
        self.view.addSubview(self.largepictureImageView)
        self.view.addSubview(self.mediumpictureImageView)
        self.view.addSubview(self.thumbnailImageView)
    }
    
    func setupImageViewCostraints() {
        largepictureImageView.snp.makeConstraints{(make) -> Void in
            make.top.equalTo((labelDictionary[22]?.snp.bottom)!).offset(5)
            make.centerX.equalTo(view)
        }
        mediumpictureImageView.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(largepictureImageView.snp.bottom).offset(5)
            make.centerX.equalTo(view)
        }
        thumbnailImageView.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(mediumpictureImageView.snp.bottom).offset(5)
            make.centerX.equalTo(view)
        }
    }
    
    func downloadPictures() {
     let downloadUrlLarge = URL(string: user.picture.large)!
     let downloadUrlMedium = URL(string: user.picture.medium)!
     let downloadUrlThumbnail = URL(string: user.picture.thumbnail)!
     
     largepictureImageView.af_setImage(withURL: downloadUrlLarge as URL)
     mediumpictureImageView.af_setImage(withURL: downloadUrlMedium as URL)
     thumbnailImageView.af_setImage(withURL: downloadUrlThumbnail as URL)
     }
}
