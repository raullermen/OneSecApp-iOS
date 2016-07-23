//
//  CalendarioBotaoReservarViewCell.swift
//  OneSecApp
//
//  Created by Raul Lermen on 4/9/16.
//  Copyright © 2016 Raul Lermen. All rights reserved.
//


import UIKit

class CalendarioBotaoReservarViewCell: UITableViewCell {
    
    @IBOutlet weak var _BackgroundView: UIView!
    @IBOutlet weak var _HorarioReserva: UILabel!
    @IBOutlet weak var _TextoReserva: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}