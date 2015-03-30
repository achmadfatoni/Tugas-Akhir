//
//  FlightTableViewCell.swift
//  Tugas Akhir
//
//  Created by Achmad Fatoni on 3/30/15.
//  Copyright (c) 2015 Achmad Fatoni. All rights reserved.
//

import UIKit

class FlightTableViewCell: UITableViewCell {

    @IBOutlet weak var maskapaiLabel: UILabel!
    @IBOutlet weak var jamLabel: UILabel!
    @IBOutlet weak var hargaLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
