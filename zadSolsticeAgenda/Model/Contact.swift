//
//  Contact.swift
//  zadSolsticeAgenda
//
//  Created by Alejandro De Jesus on 19/01/2020.
//  Copyright © 2020 Alejandro De Jesus. All rights reserved.
//

import Foundation

class Contact {
    var name: String
    var id: String
    var companyName: String
    var isFavorite: Bool
    var smallImageURL: String
    var largeImageURL: String
    var emailAdress: String
    var birthdate: String
    var phone: Phone
    var adress: Adress
    
    public init(name: String, id: String, companyName: String, isFavorite: Bool, smallImageURL: String, largeImageURL: String, emailAdress: String, birthdate: String, phone: Phone, adress: Adress) {
        self.name = name
        self.id = id
        self.companyName = companyName
        self.isFavorite = isFavorite
        self.smallImageURL = smallImageURL
        self.largeImageURL = largeImageURL
        self.emailAdress = emailAdress
        self.birthdate = birthdate
        self.phone = phone
        self.adress = adress
    }
    
     public init(dictonary: [String : AnyObject]) {
        name = dictonary["name"] as? String ?? "No data"
        id = dictonary["id"] as? String ?? "No data"
        companyName = dictonary["companyName"] as? String ?? "No data"
        isFavorite = dictonary["isFavorite"] as? Bool ?? false
        smallImageURL = dictonary["smallImageURL"] as? String ?? "No data"
        largeImageURL = dictonary["largeImageURL"] as? String ?? "No data"
        emailAdress = dictonary["emailAddress"] as? String ?? "No data"
        birthdate = dictonary["birthdate"] as? String ?? "No data"
        phone = Phone(dictonary: dictonary["phone"] as! [String : AnyObject])
        adress = Adress(dictonary: dictonary["address"] as! [String : AnyObject])
        }
}

struct Phone {
    var work: String
    var home: String
    var mobile: String
    
    public init(dictonary: [String : AnyObject]) {
        work = dictonary["work"] as? String ?? "No data"
        home = dictonary["home"] as? String ?? "No data"
        mobile = dictonary["mobile"] as? String ?? "No data"
    }
}

struct Adress {
    var street: String
    var city: String
    var state: String
    var country: String
    var zipcode: String
    
    public init(dictonary: [String : AnyObject]) {
        street = dictonary["street"] as? String ?? ""
        city = dictonary["city"] as? String ?? ""
        state = dictonary["state"] as? String ?? ""
        country = dictonary["country"] as? String ?? ""
        zipcode = dictonary["zipcode"] as? String ?? ""
    }
}
