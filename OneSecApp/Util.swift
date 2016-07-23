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
        return UIColor(red: 255/255, green: 27/255, blue: 86/255, alpha: 1)
    }
    
    class func AppNavigationVermelho()->UIColor{
        return UIColor(red: 255/255, green: 27/255, blue: 86/255, alpha: 1)
    }
    
    //GET lista reservas Mobile
    class func FormataDataParaRequest(data: NSDate)->String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.stringFromDate(data)
    }
    
    //Formatacao da label da Lista de Horarios
    class func FormataDataParaTituloReserva(data: NSDate)->String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.stringFromDate(data)
    }
    
    //Formatacao da header da lista de horarios
    class func FormataDataParaTituloHeader(data: NSDate)->String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd:MM-yyyy"
        return dateFormatter.stringFromDate(data)
    }
    
    //Formatacao do post de envio de nova data
    class func FormataDataParaEnvioPost(data: NSDate)->String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        return dateFormatter.stringFromDate(data)
    }
    
    //Formato de horario que chega do webservice
    class func FormataStringParaData(date: String)->NSDate{
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.dateFromString(date)!
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