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
}