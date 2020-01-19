//
//  ManagerContact.swift
//  zadSolsticeAgenda
//
//  Created by Alejandro De Jesus on 19/01/2020.
//  Copyright © 2020 Alejandro De Jesus. All rights reserved.
//

import Foundation



import Foundation
import Alamofire

class ContactService {
    func getContactsCategotized(completion: @escaping (([String : [Contact]]) -> Void)) { //Service returns a collection of Contacts satisfying the view requirements. Categorized in favorite / !favorite and in ascending alphabetic order.
        let DAO = ContactDAO()
        DAO.getContacts { (ContactsResponse) in
            var favoriteContacts: [Contact] = []
            var otherContacts: [Contact] = []
            for oneContact in ContactsResponse {
                if oneContact.isFavorite {
                    favoriteContacts.append(oneContact)
                } else {
                    otherContacts.append(oneContact)
                }
            }
            
            favoriteContacts.sort { (contactA, contactB) -> Bool in
                contactA.name < contactB.name
            }
            
            otherContacts.sort { (contactA, contactB) -> Bool in
                contactA.name < contactB.name
            }
            
            let contactsDictonary = ["FAVORITE CONTACTS" : favoriteContacts, "OTHER CONTACTS" : otherContacts]
            completion(contactsDictonary)
        }
    }
}

class ContactDAO {
    func getContacts(completion: @escaping (([Contact]) -> Void) ) { //Data Access Object will return unsorted list of Contacts
        Alamofire.request(k.url).responseJSON { (Response) in
            if let rootArray = Response.value as? [[String : AnyObject]] {
                var arrayOfContacts: [Contact] = []
                for oneDictonary in rootArray {
                    let contactObject = Contact(dictonary: oneDictonary)
                    arrayOfContacts.append(contactObject)
                }
                completion(arrayOfContacts)
            }
        }
    }
}
