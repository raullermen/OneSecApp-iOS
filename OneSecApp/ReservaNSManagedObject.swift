//
//  ReservaNSObject.swift
//  OneSecApp
//
//  Created by Raul Lermen on 3/29/16.
//  Copyright © 2016 Raul Lermen. All rights reserved.
//

import UIKit
import Foundation
import CoreData

@objc(Reservar)
class ReservaNSManagedObject: NSManagedObject {
    
    @NSManaged var ReservationStatus: Int
    @NSManaged var ReservationType: String
    @NSManaged var Start: NSDate
    @NSManaged var End: Int
    @NSManaged var ClientId: Int
    @NSManaged var CompanyId: String
    @NSManaged var ServiceId: String
    @NSManaged var ResourceId: String
    @NSManaged var Id: String
    
    class func createInManagedObjectContext(res: ReservaDTO) -> ReservaNSManagedObject {
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Reserva", inManagedObjectContext: context) as! ReservaNSManagedObject
        
//        newItem.empresaId = res.EmpresaId
//        newItem.empresaNome = res.EmpresaNome
//        newItem.reservaData = res.ReservaData
//        newItem.reservaId = res.ReservaId
//        newItem.reservaStatus = res.ReservaStatus
//        newItem.servicoNome = res.ServicoNome
        
        return newItem
    }
    
    class func ListarHorarios() -> Array<ReservaDTO>{
        let appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDel.managedObjectContext
        let request = NSFetchRequest(entityName: "Reserva")
        
        let sortDescriptor = NSSortDescriptor(key: "ReservaData", ascending: true)
        let sortDescriptors = [sortDescriptor]
        request.sortDescriptors = sortDescriptors
        
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.executeFetchRequest(request)
            
            var dtos = Array<ReservaDTO>()
            
            for item in results {
                let meddtop = ReservaDTO()
                
//                meddtop.EmpresaId = item.empresaId
//                meddtop.EmpresaNome = item.empresaNome
//                meddtop.ReservaData = item.reservaData
//                meddtop.ReservaId = item.reservaId
//                meddtop.ReservaStatus = item.reservaStatus
//                meddtop.ServicoNome = item.servicoNome
                
                dtos.append(meddtop)
            }
            
            return dtos
        } catch {
            return Array<ReservaDTO>()
        }
    }
    
    class func Salvar(res: ReservaDTO) {
        let appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDel.managedObjectContext
        
        do {
            createInManagedObjectContext(res)
            try context.save()
        } catch {
            print(error)
        }
    }
    
}