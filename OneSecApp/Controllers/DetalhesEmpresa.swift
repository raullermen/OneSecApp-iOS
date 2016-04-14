//
//  EmpresasReservarHorario.swift
//  OneSecApp
//
//  Created by Raul Lermen on 4/4/16.
//  Copyright © 2016 Raul Lermen. All rights reserved.
//

import UIKit
import STPopup

class DetalhesEmpresa: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let SCREENSIZE: CGRect = UIScreen.mainScreen().bounds
    
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AjustaLayout()
        table.delegate = self
        table.dataSource = self
        
        [NSUserDefaults .standardUserDefaults() .setInteger(0, forKey: "idProfissional")]
    }
    
    override func viewWillAppear(animated: Bool) {
        if NSUserDefaults().integerForKey("idProfissional") > 0 {
            self.hidesBottomBarWhenPushed = true
            self.performSegueWithIdentifier("segueCalendarioEmpresa", sender: nil)
        }
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
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            self.table.registerNib(UINib(nibName: "EmpresaReservaHorarioHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "EmpresaReservaHorarioHeaderTableViewCell")
            let cell = tableView.dequeueReusableCellWithIdentifier("EmpresaReservaHorarioHeaderTableViewCell", forIndexPath: indexPath) as! EmpresaReservaHorarioHeaderTableViewCell
            
            return cell
            
        }
        else if indexPath.row == 1 {
            self.table.registerNib(UINib(nibName: "BotaoReservarHorarioViewCell", bundle: nil), forCellReuseIdentifier: "BotaoReservarHorarioViewCell")
            let cell = tableView.dequeueReusableCellWithIdentifier("BotaoReservarHorarioViewCell", forIndexPath: indexPath) as! BotaoReservarHorarioViewCell
            
            return cell
        }
        else if indexPath.row == 2 {
            self.table.registerNib(UINib(nibName: "EmpresaDetalhesDescricaoViewCell", bundle: nil), forCellReuseIdentifier: "EmpresaDetalhesDescricaoViewCell")
            let cell = tableView.dequeueReusableCellWithIdentifier("EmpresaDetalhesDescricaoViewCell", forIndexPath: indexPath) as! EmpresaDetalhesDescricaoViewCell
            
            return cell
        }
        else if indexPath.row == 3 {
            self.table.registerNib(UINib(nibName: "EmpresaDetalhesHorarioFuncionamentoViewCell", bundle: nil), forCellReuseIdentifier: "EmpresaDetalhesHorarioFuncionamentoViewCell")
            let cell = tableView.dequeueReusableCellWithIdentifier("EmpresaDetalhesHorarioFuncionamentoViewCell", forIndexPath: indexPath) as! EmpresaDetalhesHorarioFuncionamentoViewCell
            
            return cell
        }
        else {
            self.table.registerNib(UINib(nibName: "EmpresaDetalhesLocalizacaoViewCell", bundle: nil), forCellReuseIdentifier: "EmpresaDetalhesLocalizacaoViewCell")
            let cell = tableView.dequeueReusableCellWithIdentifier("EmpresaDetalhesLocalizacaoViewCell", forIndexPath: indexPath) as! EmpresaDetalhesLocalizacaoViewCell
            
            return cell
        }

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 1 {

            let _popViewController = NSBundle.mainBundle().loadNibNamed("EmpresaReservaPopView", owner: self, options: nil).first as! UITableViewController
            
            let popup = STPopupController(rootViewController: _popViewController)
            
            popup.navigationBar.barTintColor = Util.AppVermelho()
            popup.navigationBar.tintColor = UIColor.whiteColor()
            popup.navigationBar.barStyle = .Default
            
            let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "GothamBold", size: 17.0)!]

            popup.navigationBar.titleTextAttributes = titleDict as? [String : AnyObject]
            
            popup.cornerRadius = 15
            popup.presentInViewController(self)
            
            
        }
    }
}
