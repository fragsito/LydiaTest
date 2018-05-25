//
//  ViewController.swift
//  LydiaTest
//
//  Created by Maxime Bertaux on 22/05/2018.
//  Copyright © 2018 Maxime Bertaux. All rights reserved.
//

struct content : Decodable {
    let results : [randomuser]
    let info : infoRoot
}

struct randomuser : Decodable {
    let gender : String
    let name : names
    let location : location
    let email : String
    let login : logins
    let dob : String
    let registered : String
    let phone : String
    let cell : String
    let id : ids
    let picture : pictures
    let nat : String
}

struct names : Decodable {
    let title : String
    let first : String
    let last : String
}

struct location : Decodable {
    let street : String
    let city : String
    let state : String
    let postcode : Int! //String
}

struct logins : Decodable {
    let username : String
    let password : String
    let salt : String
    let md5 : String
    let sha1 : String
    let sha256 : String
}

struct ids : Decodable {
    let name : String
    let value : String?
}

struct pictures : Decodable {
    let large : String
    let medium : String
    let thumbnail : String
}

struct infoRoot : Decodable {
    let seed : String
    let results : Int
    let page : Int
    let version : String
}

import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let randomuserURL = "https://randomuser.me/api/?results=10"
    var stringContent = (String)()
    var users = [randomuser]()
    let defaults = UserDefaults.standard
    var stringStored : String = ""
    var randomuserInfosTableView = UITableView()
    var cell = UITableViewCell()
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        randomuserInfosTableView = UITableView(frame: UIScreen.main.bounds, style: UITableViewStyle.plain)
        randomuserInfosTableView.delegate = self
        randomuserInfosTableView.dataSource = self
        randomuserInfosTableView.register(RandomuserTableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.randomuserInfosTableView)
        self.randomuserInfosTableView.rowHeight = 80
        self.navigationItem.title = "Random Users"
        
        if Reachability.isConnectedToNetwork() {
            stringToJSON(stringToJson: urlToString())
        } else {
            stringToJSON(stringToJson: persistenceGetter())
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // funcs for fetch data
    func urlToString() -> String {
        if let url = URL(string: randomuserURL) {
            do {
                stringContent = try String(contentsOf: url)
                persistenceSetter(stringToStore: stringContent)
            } catch {
                print("error with the content")
            }
        } else {
            print("error with the URL")
        }
        
        return stringContent
    }
    
    func stringToJSON(stringToJson: String) {
        let data = stringToJson.data(using: .utf8)!
        
        do {
            let finalContent = try JSONDecoder().decode(content.self, from: data)
            users = finalContent.results
        } catch {
            print(error)
            stringToJSON(stringToJson: urlToString())
        }
    }
    
    // funcs for data persistence
    func persistenceSetter(stringToStore: String) {
        defaults.set(stringToStore, forKey: "content")
    }
    
    func persistenceGetter() -> String {
        let data = defaults.string(forKey: "content")
        
        return data!
    }
    
    // funcs for tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! RandomuserTableViewCell
        let user = users[indexPath.row]
        
        cell.firstNameLabel.text = user.name.first
        cell.lastNameLabel.text = user.name.last
        cell.emailLabel.text = user.email
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = RandomuserInfoViewController()
        let backItem = UIBarButtonItem()
        
        tableView.deselectRow(at: indexPath, animated: true)
        destination.user = users[indexPath.row]
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        navigationController?.pushViewController(destination, animated: true)
    }
}
