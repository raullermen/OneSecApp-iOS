//
//  PerfilHeaderTableCell.swift
//  OneSecApp
//
//  Created by Raul Lermen on 4/17/16.
//  Copyright © 2016 Raul Lermen. All rights reserved.
//

import UIKit

class PerfilHeaderTableCell: UITableViewCell {
    
    @IBOutlet weak var FotoPerfil: UIImageView!
    @IBOutlet weak var Nome: UILabel!
    @IBOutlet weak var TelefoneCelular: UILabel!
    @IBOutlet weak var Email: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.FotoPerfil.layer.cornerRadius = self.FotoPerfil.frame.size.width / 2
        self.FotoPerfil.clipsToBounds = true
        self.FotoPerfil.layer.borderWidth = 3.0
        self.FotoPerfil.layer.borderColor = UIColor.whiteColor().CGColor
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}