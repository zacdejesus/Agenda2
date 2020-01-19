//
//  GenericContactDetailTableViewCell.swift
//  SolsticeAgenda
//
//  Created by Tobias Lewinzon on 30/11/2019.
//  Copyright © 2019 Tobias Lewinzon. All rights reserved.
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
