//
//  HomeTableViewController.swift
//  zadSolsticeAgenda
//
//  Created by Alejandro De Jesus on 21/01/2020.
//  Copyright © 2020 Alejandro De Jesus. All rights reserved.
//

import UIKit

protocol ContactFavoriteDelegate {
    func triggerFavorite(indexPath: IndexPath)
}

class HomeTableViewController: UITableViewController, ContactFavoriteDelegate  {
    
    var dataSource: [[Contact]] = []
    var sectionTitles: [String] = []
    
    var userHasChangedFavorite = false
    var indexPathToUpdate: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "contactCell", bundle: nil), forCellReuseIdentifier: "contactCell")
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {

        if userHasChangedFavorite {
            updateData(indexPath: indexPathToUpdate!)
            tableView.reloadData()
        }
        userHasChangedFavorite = false
    }
    
    func getData() {
        let service = ManagerContact()
        service.getContactsCategotized { (response) in
            for (key, value) in response {
                self.sectionTitles.append(key)
                self.dataSource.append(value)
            }
            self.tableView.reloadData()
        }
    }

    func triggerFavorite(indexPath: IndexPath) {
        userHasChangedFavorite = !userHasChangedFavorite
        indexPathToUpdate = indexPath
        
    }
    
    func updateData(indexPath: IndexPath) {
        let contact = dataSource[indexPath.section][indexPath.row]
        
        if indexPath.section == 0 { //The contact was favorite
            dataSource[indexPath.section].remove(at: indexPath.row)
            dataSource[1].append(contact)
            dataSource[1].sort { (contactA, contactB) -> Bool in
                return contactA.name < contactB.name
            }
            
        } else { //The contact was !favorite
            dataSource[indexPath.section].remove(at: indexPath.row)
            dataSource[0].append(contact)
            dataSource[0].sort { (contactA, contactB) -> Bool in
                return contactA.name < contactB.name
            }
        }
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionTitles[section]
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
        if let customCell = cell as? ContactTableViewCell {
            customCell.setupUI(contact: dataSource[indexPath.section][indexPath.row])
        }
         return cell
    }
    
    var selectedIndexPath: IndexPath?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        performSegue(withIdentifier: "goToDetail", sender: self)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailTVC = segue.destination as? DetailTableViewController {
            detailTVC.contact = self.dataSource[selectedIndexPath!.section][selectedIndexPath!.row]
            detailTVC.contactFavoriteDelegate = self
            detailTVC.myIndexPath = selectedIndexPath
        }
    }
    

}

extension Contact {
    func toggleFavorite() {
        self.isFavorite = !self.isFavorite
    }
}
