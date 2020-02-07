//
//  HomeTableViewController.swift
//  zadSolsticeAgenda
//
//  Created by Alejandro De Jesus on 21/01/2020.
//  Copyright © 2020 Alejandro De Jesus. All rights reserved.
//

import UIKit

class GenericContactDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var dataTypeLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var phoneTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(contactData: GenericContactData) {
        dataTypeLabel.text = contactData.type.uppercased()
        dataLabel.text = contactData.mainData
        if contactData.phoneType != nil {
            phoneTypeLabel.text = contactData.phoneType!
        } else {
            phoneTypeLabel.isHidden = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
