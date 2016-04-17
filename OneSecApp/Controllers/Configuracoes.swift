//
//  Configuracoes.swift
//  OneSecApp
//
//  Created by Raul Lermen on 2/14/16.
//  Copyright © 2016 Raul Lermen. All rights reserved.
//

import UIKit

class Configuracoes: UITableViewController {

    let SCREENSIZE: CGRect = UIScreen.mainScreen().bounds
    
    let corBordas = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1)
    let corBackgroundTabela = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1)
    
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
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        
        self.tableView.backgroundColor = corBackgroundTabela
        self.tableView.separatorColor = UIColor.clearColor()
    }
    
    // MARK: TABLE VIEW
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            return 3
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            tableView.registerNib(UINib(nibName: "PerfilHeaderTableCell", bundle: nil), forCellReuseIdentifier: "PerfilHeaderTableCell")
            let cell = tableView.dequeueReusableCellWithIdentifier("PerfilHeaderTableCell", forIndexPath: indexPath) as! PerfilHeaderTableCell
            return cell
        }else{
            self.tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
            let cell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
            
            if indexPath.row == 0 {
                
                cell.textLabel?.text = "Minha Conta"
            }
            
            if indexPath.row == 1 {
                cell.textLabel?.text = "Notificações"
            }
            
            if indexPath.row == 2 {
                cell.textLabel?.text = "Ajuda e Sobre"
            }
            
            
            //Adiciona Separador
            let separatorLineView = UIView.init(frame: CGRectMake(0, cell.bounds.size.height - 1, SCREENSIZE.width, 1))
            separatorLineView.backgroundColor = corBordas
            cell.contentView.addSubview(separatorLineView)
            
            cell.accessoryType = .DisclosureIndicator
        
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return CGFloat(self.SCREENSIZE.width * 0.7)
        }
        
        return 44
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //self.table?.deselectRowAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier("segueDetalhesReserva", sender: self)
    }
    
    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return 1
    }

}
