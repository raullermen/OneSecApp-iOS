//
//  EmpresaTableViewCell.swift
//  OneSecApp
//
//  Created by Raul Lermen on 2/14/16.
//  Copyright © 2016 Raul Lermen. All rights reserved.
//

import UIKit

class EmpresaTableViewCell: UITableViewCell {

    @IBOutlet weak var ImagemFundo: UIImageView!
    @IBOutlet weak var NomeEmpresa: UILabel!
    @IBOutlet weak var DescricaoEmpresa: UILabel!
    
    @IBOutlet weak var overlayBlur: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
