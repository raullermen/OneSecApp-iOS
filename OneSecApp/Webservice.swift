//
//  Webservice.swift
//  OneSecApp
//
//  Created by Raul Lermen on 3/16/16.
//  Copyright © 2016 Raul Lermen. All rights reserved.
//

import Foundation
import Alamofire
import EVReflection

class Webservice  {
    
    let URLBase = "http://onesecwebapi.azurewebsites.net/api/"
    
    func GetCompanies(completion: (erro: String?, listaEmpresas: Array<CompanyDTO>?) -> Void){
        Alamofire.request(.GET, self.URLBase + "/companies").responseJSON
            { response in switch response.result {
            case .Success(let JSON):
                completion(erro: nil, listaEmpresas: JsonParse.ParseCompanies(JSON))
            case .Failure(let error):
                print("Request failed with error: \(error)")
                completion(erro: error.localizedDescription, listaEmpresas: nil)
            }
        }
    }
    
    func GetEmployees(empresaId: Int, completion: (erro: String?, listaProfissionais: Array<ProfissionalDTO>?) -> Void){
        Alamofire.request(.GET, self.URLBase + "/employees/company/" + String(empresaId)).responseJSON
            { response in switch response.result {
            case .Success(let JSON):
                completion(erro: nil, listaProfissionais: JsonParse.ParseFuncionarios(JSON))
            case .Failure(let error):
                print("Request failed with error: \(error)")
                completion(erro: error.localizedDescription, listaProfissionais: nil)
            }
        }
    }
    
    func GetMobileReservations(empresaId: Int, resourceId: Int, dataReserva: NSDate,
                               completion: (erro: String?, listaReservas: Array<MobileReservationDTO>?)-> Void){
        
        let url = self.URLBase + "MobileReservations?empresaId=" + String(empresaId) +
            "&resourceId=" + String(resourceId) + "&dataReserva=" + Util.FormataDataParaRequest(dataReserva)
        
        Alamofire.request(.GET, url).responseJSON
            { response in switch response.result {
            case .Success(let JSON):
                completion(erro: nil, listaReservas: JsonParse.ParseMobileReservations(JSON))
            case .Failure(let error):
                print("Request failed with error: \(error)")
                completion(erro: error.localizedDescription, listaReservas: nil)
            }
        }
    }
    
    func PostMobileReservation(reserva: ReservaDTO, completion: (erro: String?, reserva: ReservaDTO?)-> Void){
        let parameters = reserva.toDictionary()
        
        Alamofire.request(.POST, self.URLBase + "CompanyReservations", parameters: parameters as? [String : AnyObject], encoding: .JSON).responseJSON
            { response in switch response.result {
            case .Success(let JSON):
                completion(erro: nil, reserva: JsonParse.ParsePostedMobileReservation(JSON))
            case .Failure(let error):
                print("Request failed with error: \(error)")
                completion(erro: error.localizedDescription, reserva: nil)
            }
        }
    }
    
//    func GetCompanies(completion: (erro: String?, listaEmpresas: List<CompanyDTO>?) -> Void){
//        
//        oauth2.onAuthorize = { parameters in
//            let param = [ "codigo" : codigo, "tipoBula" : tipoBula, "idBula" : idBula ]
//            self.oauth2.request(.GET, self.URLBase + "/bulaPesquisa/selecionarBulaCompleta", parameters: param as? [String : AnyObject]).responseJSON
//                { response in switch response.result {
//                case .Success(let JSON):
//                    completion(erro: nil, detalhesBula: self.jsonParse.ParseDetalhesBula(JSON))
//                case .Failure(let error):
//                    print("Request failed with error: \(error)")
//                    completion(erro: error.localizedDescription, detalhesBula: nil)
//                    }
//            }
//        }
//        
//        oauth2.onFailure = { error in
//            if nil != error {
//                print("Authorization went wrong: \(error!)")
//            }
//        }
//        
//        oauth2.authorize()
//    }
    
    
}