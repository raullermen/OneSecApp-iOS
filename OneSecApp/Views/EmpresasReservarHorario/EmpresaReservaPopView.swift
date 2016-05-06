//
//  EmpresaReservaPopView.swift
//  OneSecApp
//
//  Created by Raul Lermen on 4/12/16.
//  Copyright © 2016 Raul Lermen. All rights reserved.
//

import UIKit

class EmpresaReservaPopView: UITableViewController {
    
    let SCREENSIZE: CGRect = UIScreen.mainScreen().bounds
    
    var _idEmpresa = Int()
    var _consultaExecutada = Bool()
    var _listaProfissionais = Array<ProfissionalDTO>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "EmpresaReservaPopView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
    //MARK: VIEW CONTROLLER
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Selecione o Profissional"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.contentSizeInPopup = CGSizeMake(self.SCREENSIZE.width * 0.8, self.SCREENSIZE.height * 0.6);
        self.landscapeContentSizeInPopup = CGSizeMake(400, 200);
        
        _idEmpresa = 2
        //CarregaDados()
        
    }
    
    // MARK: TABLE VIEW
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if _consultaExecutada {
            return _listaProfissionais.count
        }else{
            return 10
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
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
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(self.SCREENSIZE.width * 0.14)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //[NSUserDefaults .standardUserDefaults() .setInteger(self._listaProfissionais[indexPath.row].Id, forKey: "idProfissional")]
        [NSUserDefaults .standardUserDefaults() .setInteger(1, forKey: "idProfissional")]
        self.dismissViewControllerAnimated(true, completion: nil)
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
                    self.tableView.reloadData()
                })
            }
            
        })
    }

    
}
