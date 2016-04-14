//
//  EmpresaPopupTableView.swift
//  OneSecApp
//
//  Created by Raul Lermen on 4/12/16.
//  Copyright © 2016 Raul Lermen. All rights reserved.
//

import UIKit

class EmpresaPopupTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    let SCREENSIZE: CGRect = UIScreen.mainScreen().bounds
    
    internal var _idEmpresa = Int()
    
    var _consultaExecutada = Bool()
    var _listaProfissionais = Array<ProfissionalDTO>()
    
    internal func Init(){
        _idEmpresa = 2
        self.delegate = self
        self.dataSource = self
        CarregaDados()
    }
    
    // MARK: TABLE VIEW
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if _consultaExecutada {
            return _listaProfissionais.count
        }else{
            return 10
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return NSBundle.mainBundle().loadNibNamed("EmpresaReservaPopupHeaderView", owner: nil, options: nil)[0] as? UIView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(self.SCREENSIZE.width * 0.14)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if _listaProfissionais.count == 0 {
            tableView.registerNib(UINib(nibName: "EmpresaReservaPopupViewCell", bundle: nil), forCellReuseIdentifier: "EmpresaReservaPopupViewCell")
            let cell = tableView.dequeueReusableCellWithIdentifier("EmpresaReservaPopupViewCell", forIndexPath: indexPath) as! EmpresaReservaPopupViewCell
            return cell
        }
        
        tableView.registerNib(UINib(nibName: "EmpresaReservaPopupViewCell", bundle: nil), forCellReuseIdentifier: "EmpresaReservaPopupViewCell")
        let cell = tableView.dequeueReusableCellWithIdentifier("EmpresaReservaPopupViewCell", forIndexPath: indexPath) as! EmpresaReservaPopupViewCell
        
        cell.TituloLista.text = self._listaProfissionais[indexPath.row].Name
        return cell
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(self.SCREENSIZE.width * 0.14)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    //MARK: WEBSERVICE
    func CarregaDados(){
        let ws = Webservice()
        
        ws.GetEmployees(_idEmpresa, completion: { (erro, listaEmpresas) -> () in
            if erro != nil {
                print(erro)
            }else{
                self._listaProfissionais.appendContentsOf(listaEmpresas!)
                dispatch_async(dispatch_get_main_queue(),{
                    self._consultaExecutada = true
                    self.reloadData()
                })
            }
            
        })
    }
    
}