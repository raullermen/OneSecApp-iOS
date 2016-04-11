//
//  DetalheReservaViewCell.swift
//  OneSecApp
//
//  Created by Raul Lermen on 4/9/16.
//  Copyright © 2016 Raul Lermen. All rights reserved.
//

import UIKit

class DetalheReservaViewCell: UITableViewCell {
    
    @IBOutlet weak var CampoReserva: UILabel!
    @IBOutlet weak var ValorCampoReserva: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}