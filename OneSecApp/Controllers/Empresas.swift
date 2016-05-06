//
//  Empresas.swift
//  OneSecApp
//
//  Created by Raul Lermen on 2/14/16.
//  Copyright © 2016 Raul Lermen. All rights reserved.
//

import UIKit

class Empresas: UITableViewController {

    let SCREENSIZE: CGRect = UIScreen.mainScreen().bounds
    
    @IBOutlet var table: UITableView!
    
    var _consultaExecutada = Bool()
    var _listaEmpresas = Array<CompanyDTO>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AjustaLayout()
        //CarregaDados()
    }
    
    // MARK: LAYOUT
    func AjustaLayout(){
        self.navigationController?.navigationBar.translucent = true
        
        let font = UIFont(name: "GothamBold", size: 22.0)
        if let font = font {
            let titleDict: NSDictionary = [NSForegroundColorAttributeName: Util.AppVermelho(), NSFontAttributeName: font]
            self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : AnyObject]
        }
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
    }
    
    
    // MARK: TABLE VIEW
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if _consultaExecutada {
            return _listaEmpresas.count
        }else{
            return 10
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return NSBundle.mainBundle().loadNibNamed("ListaEmpresasHeader", owner: nil, options: nil)[0] as? UIView
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if _listaEmpresas.count == 0 {
                tableView.registerNib(UINib(nibName: "EmpresaTableViewCell", bundle: nil), forCellReuseIdentifier: "EmpresaTableViewCell")
                let cell = tableView.dequeueReusableCellWithIdentifier("EmpresaTableViewCell", forIndexPath: indexPath) as! EmpresaTableViewCell
                return cell
        }
        
        tableView.registerNib(UINib(nibName: "EmpresaTableViewCell", bundle: nil), forCellReuseIdentifier: "EmpresaTableViewCell")
        let cell = tableView.dequeueReusableCellWithIdentifier("EmpresaTableViewCell", forIndexPath: indexPath) as! EmpresaTableViewCell
        
        cell.NomeEmpresa.text = self._listaEmpresas[indexPath.row].Name
        cell.DescricaoEmpresa.text = self._listaEmpresas[indexPath.row].Description
        return cell
    
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(self.SCREENSIZE.width / 2.2)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.table?.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = self.table?.cellForRowAtIndexPath(NSIndexPath(forItem: indexPath.row, inSection: 0)) as! EmpresaTableViewCell
        cell.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)

        self.performSegueWithIdentifier("segueEmpresaDetalhes", sender: self)
    }
    
    //MARK: WEBSERVICE
    func CarregaDados(){
        let ws = Webservice()
        
        ws.GetCompanies({ (erro, listaEmpresas) -> () in
            if erro != nil {
                print(erro)
            }else{
                self._listaEmpresas.appendContentsOf(listaEmpresas!)
                dispatch_async(dispatch_get_main_queue(),{
                    self._consultaExecutada = true
                    self.table?.reloadData()
                })
            }
            
        })
    }

}
