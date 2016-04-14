//
//  Webservice.swift
//  OneSecApp
//
//  Created by Raul Lermen on 3/16/16.
//  Copyright © 2016 Raul Lermen. All rights reserved.
//

import Foundation
import Alamofire

class Webservice  {
    
    let URLBase = "https://onesecapi.herokuapp.com/api/v1/"
    
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
    
    func RetornaListaHorarios()-> Array<HorarioEmpresaDTO>{
        var lista = Array<HorarioEmpresaDTO>()
        
        let df = NSDateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let t1 = HorarioEmpresaDTO()
        t1.DataHora = df.dateFromString("2016-03-17 17:00:00")!
        t1.Disponivel = true
        t1.empresaId = 1
        
        let t2 = HorarioEmpresaDTO()
        t2.DataHora = df.dateFromString("2016-03-17 18:00:00")!
        t2.Disponivel = true
        t2.empresaId = 1
        
        let t3 = HorarioEmpresaDTO()
        t3.DataHora = df.dateFromString("2016-03-18 17:00:00")!
        t3.Disponivel = true
        t3.empresaId = 1
        
        let t4 = HorarioEmpresaDTO()
        t4.DataHora = df.dateFromString("2016-03-19 17:00:00")!
        t4.Disponivel = true
        t4.empresaId = 1
        
        lista.append(t1)
        lista.append(t2)
        lista.append(t3)
        lista.append(t4)
        
        return lista
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