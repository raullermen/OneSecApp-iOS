//
//  ReservaDTO.swift
//  OneSecApp
//
//  Created by Raul Lermen on 3/29/16.
//  Copyright © 2016 Raul Lermen. All rights reserved.
//

import Foundation
import EVReflection

class ReservaDTO: EVObject {
    
    var Id = Int()
    var ReservationStatus = Int()
    var ReservationType = Int()
    var Start = String()
    var End = String()
    var ClientId = Int()
    var CompanyId = Int()
    var ResourceId = Int()
    var ServiceId = Int()
    
    var RowIndex = Int()
    
    required init(){
        
    }
    
}