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
    
    @NSManaged var empresaId: Int
    @NSManaged var empresaNome: String
    @NSManaged var reservaData: NSDate
    @NSManaged var reservaId: Int
    @NSManaged var reservaStatus: Int
    @NSManaged var servicoNome: String
    
    class func createInManagedObjectContext(res: ReservaDTO) -> ReservaNSManagedObject {
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Reserva", inManagedObjectContext: context) as! ReservaNSManagedObject
        
        newItem.empresaId = res.EmpresaId
        newItem.empresaNome = res.EmpresaNome
        newItem.reservaData = res.ReservaData
        newItem.reservaId = res.ReservaId
        newItem.reservaStatus = res.ReservaStatus
        newItem.servicoNome = res.ServicoNome
        
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
                
                meddtop.EmpresaId = item.empresaId
                meddtop.EmpresaNome = item.empresaNome
                meddtop.ReservaData = item.reservaData
                meddtop.ReservaId = item.reservaId
                meddtop.ReservaStatus = item.reservaStatus
                meddtop.ServicoNome = item.servicoNome
                
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

//    class func Deletar(med: BulaDetalhadaDTO) {
//        let appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
//        let context:NSManagedObjectContext = appDel.managedObjectContext
//        let request = NSFetchRequest(entityName: "Medicamento")
//        let predicate = NSPredicate(format: "codigo = %@ AND idBula = %@ AND tipoBula = %@", NSString(string: med.Codigo), NSNumber(integer: med.IdBula), NSNumber(integer: med.TipoBula))
//        var results:NSArray = NSArray()
//        
//        request.predicate = predicate
//        request.returnsObjectsAsFaults = false
//        results = try! context.executeFetchRequest(request)
//        
//        if results.count > 0 {
//            for item in results {
//                context.deleteObject(item as! NSManagedObject)
//            }
//            do {
//                try context.save()
//            } catch _ {
//            }
//        }
//    }
//    
//    class func DeletarTodos() {
//        let appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
//        let context:NSManagedObjectContext = appDel.managedObjectContext
//        let request = NSFetchRequest(entityName: "Medicamento")
//        var results:NSArray = NSArray()
//        
//        request.returnsObjectsAsFaults = false
//        results = try! context.executeFetchRequest(request)
//        
//        if results.count > 0 {
//            for item in results {
//                context.deleteObject(item as! NSManagedObject)
//            }
//            do {
//                try context.save()
//            } catch _ {
//            }
//        }
//    }
//    
//    class func isFavorito(med: BulaDetalhadaDTO) -> Bool {
//        let appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
//        let context:NSManagedObjectContext = appDel.managedObjectContext
//        let request = NSFetchRequest(entityName: "Medicamento")
//        let predicate = NSPredicate(format: "codigo = %@ AND idBula = %@ AND tipoBula = %@", NSString(string: med.Codigo), NSNumber(integer: med.IdBula), NSNumber(integer: med.TipoBula))
//        var results:NSArray = NSArray()
//        
//        request.predicate = predicate
//        request.returnsObjectsAsFaults = false
//        results = try! context.executeFetchRequest(request)
//        
//        return results.count > 0 ? true : false
//    }
    
}