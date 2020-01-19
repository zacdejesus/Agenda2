//
//  ContactTableViewCell.swift
//  SolsticeAgenda
//
//  Created by Tobias Lewinzon on 29/11/2019.
//  Copyright © 2019 Tobias Lewinzon. All rights reserved.
//

import UIKit

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

        // Configure the view for the selected state
    }

}
