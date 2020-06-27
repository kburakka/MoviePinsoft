//
//  DetailTableViewCell.swift
//  MoviePinsoft
//
//  Created by burak kaya on 27/06/2020.
//  Copyright © 2020 burak kaya. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(keyValue : KeyValue){
        descLabel.text = keyValue.value
        titleLabel.text = keyValue.key
    }
    
}
