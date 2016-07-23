//
//  JsonParse.swift
//  OneSecApp
//
//  Created by Raul Lermen on 4/10/16.
//  Copyright © 2016 Raul Lermen. All rights reserved.
//

import Foundation

class JsonParse {
    
    class func ParseCompanies(JSON: AnyObject) -> Array<CompanyDTO>? {
    
        if let companies = JSON["companies"] as? NSArray {
            
            var companiesList = Array<CompanyDTO>()
            
            for company in companies{
                let cmpdto = CompanyDTO()
                
                cmpdto.Id = company["id"] as! Int
                cmpdto.Name = company["name"] as! String
                cmpdto.Description = company["description"] as! String
                cmpdto.location = company["location"] as! String
                    
                companiesList.append(cmpdto)
            }
            
            return companiesList
        }
        
        return nil
    }
    
    class func ParseFuncionarios(JSON: AnyObject) -> Array<ProfissionalDTO>? {
        
        if let profissionais = JSON["employees"] as? NSArray {
            
            var profissionalList = Array<ProfissionalDTO>()
            
            for profissional in profissionais {
                let funcdto = ProfissionalDTO()
                
                funcdto.Id = profissional["id"] as! Int
                funcdto.Company_id = profissional["company_id"] as! Int
                funcdto.Name = profissional["name"] as! String
                
                profissionalList.append(funcdto)
            }
            
            return profissionalList
        }
        
        return nil
    }
    
    class func ParseMobileReservations(JSON: AnyObject) -> Array<MobileReservationDTO>? {
        
        if let reservas = JSON as? NSArray {
            
            var listaReservas = Array<MobileReservationDTO>()
            
            for reserva in reservas {
                let funcdto = MobileReservationDTO()
                
                funcdto.Start = Util.FormataStringParaData(reserva["Start"] as! String)
                funcdto.End = Util.FormataStringParaData(reserva["End"] as! String)
                funcdto.isAvailable = reserva["Available"] as! Bool
                
                listaReservas.append(funcdto)
            }
            
            return listaReservas
        }
        
        return nil
    }
    
    class func ParsePostedMobileReservation(JSON: AnyObject) -> ReservaDTO? {
        
        let res = ReservaDTO()
        res.ReservationStatus = JSON["ReservationStatus"] as! Int
        res.ReservationType = JSON["ReservationType"] as! Int
        res.Start = JSON["Start"] as! String
        res.End = JSON["End"] as! String
        res.CompanyId = JSON["CompanyId"] as! Int
        res.ServiceId = JSON["ServiceId"] as! Int
        res.ResourceId = JSON["ResourceId"] as! Int
        res.Id = JSON["Id"] as! Int

        return nil
    }
}