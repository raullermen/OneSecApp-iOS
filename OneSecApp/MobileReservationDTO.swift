//
//  HorarioEmpresaDTO.swift
//  OneSecApp
//
//  Created by Raul Lermen on 3/16/16.
//  Copyright © 2016 Raul Lermen. All rights reserved.
//
import Foundation

class MobileReservationDTO {
    
    var Id = Int() //Recebo esse valor null e ele eh preenchido quando tento fazer uma reserva
    var Start = NSDate()
    var End = NSDate()
    var isAvailable = Bool()
    
    init(){
        
    }
    
    func isSameDateThan(date: NSDate)->Bool{
        
        let now = date
        let olderDate = self.Start
        
        let order = NSCalendar.currentCalendar().compareDate(now, toDate: olderDate, toUnitGranularity: .Day)
        
        if order == .OrderedSame{
            return true
        }else{
            return false
        }
    }
    
    func retornaData()->String{
        let date = self.Start //get the time, in this case the time an object was created.
        //format date
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm" //format style. Browse online to get a format that fits your needs.
        let dateString = dateFormatter.stringFromDate(date)
        return dateString //prints out 10:12
    }
    
}
