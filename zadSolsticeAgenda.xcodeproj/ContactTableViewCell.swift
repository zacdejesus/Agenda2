//
//  HomeTableViewController.swift
//  zadSolsticeAgenda
//
//  Created by Alejandro De Jesus on 21/01/2020.
//  Copyright © 2020 Alejandro De Jesus. All rights reserved.
//

import UIKit
import Kingfisher

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactSublabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func setupUI(contact: Contact) {
        //Setup image
        contactImage.kf.indicatorType = .activity
        let imageURL = URL(string: contact.smallImageURL)
        contactImage.kf.setImage(with: imageURL, placeholder: UIImage(named: "UserSmall"))
        //Setup name
        if contact.isFavorite {
            contactNameLabel.text = "⭐️ \(contact.name)"
        } else {
            contactNameLabel.text = contact.name
        }
        //Setup subtitle
        if contact.companyName == "No data" {
            contactSublabel.isHidden = true
        } else {
            contactSublabel.text = contact.companyName
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
