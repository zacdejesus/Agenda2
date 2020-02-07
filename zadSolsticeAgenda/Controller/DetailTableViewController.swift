//
//  HomeTableViewController.swift
//  zadSolsticeAgenda
//
//  Created by Alejandro De Jesus on 21/01/2020.
//  Copyright © 2020 Alejandro De Jesus. All rights reserved.
//

import UIKit


extension Contact {
    func extractData() -> [[String : String]] {
        
        var array: [[String : String]] = []
        
        let rawArray = [["type" : "Name", "value" : self.name],
                        ["type" : "Mobile" , "value" : self.phone.mobile],
                        ["type" : "Work" , "value" : self.phone.work],
                        ["type" : "Home" , "value" : self.phone.home],
                        ["type" : "Adress" , "value" : "\(self.adress.street) \(self.adress.city) \(self.adress.state) \(self.adress.zipcode) \(self.adress.country)"],
                        ["type" : "email", "value" : self.emailAdress]]
        
        // Filter array to prevent rows with no data
        for dataInstance in rawArray {
            if dataInstance["value"] != "No data" && dataInstance["value"] != " " && dataInstance["value"] != ""{
                array.append(dataInstance)
            }
        }
        return array
    }
    
}

struct GenericContactData {
    var type: String
    var phoneType: String?
    var mainData: String
    
    init(type: String, phoneType: String?, mainData: String) {
        self.type = type
        self.phoneType = phoneType
        self.mainData = mainData
    }
}

struct MainContacData {
    var largeImage: String
    var name: String
    var company: String
    
    init(largeImage: String, name: String, company: String) {
        self.largeImage = largeImage
        self.name = name
        self.company = company
    }
}

class DetailTableViewController: UITableViewController {
    
    @IBOutlet weak var toggleFavoriteButton: UIBarButtonItem!
    
    var contactParams: [[String : String]]?
    var contact: Contact?
    
    var contactFavoriteDelegate: ContactFavoriteDelegate?
    var myIndexPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        contactParams = contact?.extractData()
        
        self.tableView.register(UINib(nibName: "genericContactDetailCell", bundle: nil), forCellReuseIdentifier: "genericContactCell")
        self.tableView.register(UINib(nibName: "mainContactDetailCell", bundle: nil), forCellReuseIdentifier: "mainContactCell")

    }

    @IBAction func toggleFavorite(_ sender: UIBarButtonItem) {
        contact?.toggleFavorite()
        setupUI()
        contactFavoriteDelegate?.triggerFavorite(indexPath: myIndexPath!)
    }
    
    func setupUI() {
        if let contact = contact {
            if contact.isFavorite {
                toggleFavoriteButton.image = UIImage(named: "favTrue")
            } else {
                toggleFavoriteButton.image = UIImage(named: "favFalse")
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactParams!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "mainContactCell", for: indexPath)
            cell.selectionStyle = .none
            let mainContactData = MainContacData(largeImage: contact!.largeImageURL, name: contact!.name, company: contact!.companyName)
            if let mainCell = cell as? MianContactDetailTableViewCell {
                mainCell.setup(contactData: mainContactData)
                return mainCell
            } else {
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "genericContactCell", for: indexPath)
            cell.selectionStyle = .none
            if let genericCell = cell as? GenericContactDetailTableViewCell {
                let type = contactParams![indexPath.row]["type"]!
                let mainData =  contactParams![indexPath.row]["value"]!
                switch type {
                case "Mobile" :
                    let genericContactData = GenericContactData(type: "PHONE", phoneType: "Mobile", mainData: contact!.phone.mobile)
                    genericCell.setup(contactData: genericContactData)
                    return genericCell
                
                case "Home" :
                    let genericContactData = GenericContactData(type: "PHONE", phoneType: "Home", mainData: contact!.phone.home)
                    genericCell.setup(contactData: genericContactData)
                    return genericCell
                
                case "Work" :
                    let genericContactData = GenericContactData(type: "PHONE", phoneType: "Work", mainData: contact!.phone.work)
                    genericCell.setup(contactData: genericContactData)
                    return genericCell
                default:
                    let genericContactData = GenericContactData(type: type, phoneType: nil, mainData: mainData )
                    genericCell.setup(contactData: genericContactData)
                    return genericCell
                }
            }
            return cell
        }
    }

}

