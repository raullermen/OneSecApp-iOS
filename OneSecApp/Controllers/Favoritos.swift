//
//  Favoritos.swift
//  OneSecApp
//
//  Created by Raul Lermen on 2/14/16.
//  Copyright © 2016 Raul Lermen. All rights reserved.
//

import UIKit

class Favoritos: UITableViewController {

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
    }
    
    // MARK: TABLE VIEW
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.registerNib(UINib(nibName: "EmpresaTableViewCell", bundle: nil), forCellReuseIdentifier: "EmpresaTableViewCell")
        let cell = tableView.dequeueReusableCellWithIdentifier("EmpresaTableViewCell", forIndexPath: indexPath) as! EmpresaTableViewCell
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(self.SCREENSIZE.width / 2.2)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.table?.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = self.table?.cellForRowAtIndexPath(NSIndexPath(forItem: indexPath.row, inSection: 0)) as! EmpresaTableViewCell
        cell.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
        //let codigoLinhaSelecionada = cell.CodigoLinha.text
        //let nomeLinhaSelecionada = cell.TituloLinha.text
        
        //[NSUserDefaults .standardUserDefaults() .setObject(codigoLinhaSelecionada, forKey: "CodigoLinhaSelecionada")]
        //[NSUserDefaults .standardUserDefaults() .setObject(nomeLinhaSelecionada, forKey: "NomeLinhaSelecionada")]
        
        self.performSegueWithIdentifier("segueEmpresaDetalhes", sender: self)
    }

}
