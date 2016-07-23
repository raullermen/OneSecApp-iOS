//
//  EmpresaCalendarioHeaderView.swift
//  OneSecApp
//
//  Created by Raul Lermen on 4/8/16.
//  Copyright © 2016 Raul Lermen. All rights reserved.
//

import UIKit

class CalendarioEmpresaHeaderView: UIView {
    
    @IBOutlet weak var NomeEmpresa: UILabel!
    @IBOutlet weak var NomeServico: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "CalendarioEmpresaHeaderView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
}