//
//  Util.swift
//  OneSecApp
//
//  Created by Raul Lermen on 4/3/16.
//  Copyright © 2016 Raul Lermen. All rights reserved.
//

import UIKit

class Util {
    
    let SCREENSIZE: CGRect = UIScreen.mainScreen().bounds
    
    class func AppVermelho()->UIColor{
        return UIColor(red: 225/255, green: 41/255, blue: 61/255, alpha: 1)
    }
    
    //MARK: EFEITOS VISUAIS
    func RetonarTituloView(titulo: String) -> UILabel{
        
        let tituloContent = UIView()
        tituloContent.frame = CGRect(x: 0, y: 0, width: self.SCREENSIZE.width, height: self.SCREENSIZE.width * 0.25)
        
        let tituloTabela = UILabel()
        
        tituloTabela.text = titulo
        tituloTabela.textAlignment = NSTextAlignment.Center
        tituloTabela.font = UIFont(name: "Gotham-Light", size: 22.0)
        tituloTabela.textColor = UIColor.whiteColor()
        tituloTabela.sizeToFit()
        tituloTabela.center = tituloContent.center
        tituloTabela.frame.origin.y = tituloContent.frame.height * 0.60
        
        return tituloTabela
    }
}