//
//  EmpresasReservarHorario.swift
//  OneSecApp
//
//  Created by Raul Lermen on 4/4/16.
//  Copyright © 2016 Raul Lermen. All rights reserved.
//

import UIKit

class DetalhesEmpresa: UITableViewController {
    
    let SCREENSIZE: CGRect = UIScreen.mainScreen().bounds
    
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AjustaLayout()
    }
    
    // MARK: LAYOUT
    func AjustaLayout(){
        self.navigationController?.navigationBar.translucent = true
        
        let font = UIFont(name: "GothamBold", size: 22.0)
        if let font = font {
            let titleDict: NSDictionary = [NSForegroundColorAttributeName: Util.AppVermelho(), NSFontAttributeName: font]
            self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : AnyObject]
        }
        
        self.navigationController?.navigationBar.tintColor = Util.AppVermelho()
    }
    
    // MARK: TABLE VIEW
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            self.tableView.registerNib(UINib(nibName: "EmpresaReservaHorarioHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "EmpresaReservaHorarioHeaderTableViewCell")
            let cell = tableView.dequeueReusableCellWithIdentifier("EmpresaReservaHorarioHeaderTableViewCell", forIndexPath: indexPath) as! EmpresaReservaHorarioHeaderTableViewCell
            
            return cell
            
        }
        else if indexPath.row == 1 {
            self.tableView.registerNib(UINib(nibName: "BotaoReservarHorarioViewCell", bundle: nil), forCellReuseIdentifier: "BotaoReservarHorarioViewCell")
            let cell = tableView.dequeueReusableCellWithIdentifier("BotaoReservarHorarioViewCell", forIndexPath: indexPath) as! BotaoReservarHorarioViewCell
            
            return cell
        }
        else if indexPath.row == 2 {
            self.tableView.registerNib(UINib(nibName: "EmpresaDetalhesDescricaoViewCell", bundle: nil), forCellReuseIdentifier: "EmpresaDetalhesDescricaoViewCell")
            let cell = tableView.dequeueReusableCellWithIdentifier("EmpresaDetalhesDescricaoViewCell", forIndexPath: indexPath) as! EmpresaDetalhesDescricaoViewCell
            
            return cell
        }
        else if indexPath.row == 3 {
            self.tableView.registerNib(UINib(nibName: "EmpresaDetalhesHorarioFuncionamentoViewCell", bundle: nil), forCellReuseIdentifier: "EmpresaDetalhesHorarioFuncionamentoViewCell")
            let cell = tableView.dequeueReusableCellWithIdentifier("EmpresaDetalhesHorarioFuncionamentoViewCell", forIndexPath: indexPath) as! EmpresaDetalhesHorarioFuncionamentoViewCell
            
            return cell
        }
        else {
            self.tableView.registerNib(UINib(nibName: "EmpresaDetalhesLocalizacaoViewCell", bundle: nil), forCellReuseIdentifier: "EmpresaDetalhesLocalizacaoViewCell")
            let cell = tableView.dequeueReusableCellWithIdentifier("EmpresaDetalhesLocalizacaoViewCell", forIndexPath: indexPath) as! EmpresaDetalhesLocalizacaoViewCell
            
            return cell
        }

    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return CGFloat(self.SCREENSIZE.width / 2.2)
        }
        else if indexPath.row == 1 {
            return CGFloat(self.SCREENSIZE.width * 0.12)
        }
        else if indexPath.row == 2 {
            return CGFloat(self.SCREENSIZE.width * 0.24)
        }
        else if indexPath.row == 3 {
            return CGFloat(self.SCREENSIZE.width * 0.24)
        }
        else {
            return CGFloat(self.SCREENSIZE.width * 0.8)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 1 {
            self.hidesBottomBarWhenPushed = true
            self.performSegueWithIdentifier("segueCalendarioEmpresa", sender: nil)
        }
    }
}
