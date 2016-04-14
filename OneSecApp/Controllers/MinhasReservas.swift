//
//  MinhasReservas.swift
//  OneSecApp
//
//  Created by Raul Lermen on 2/14/16.
//  Copyright © 2016 Raul Lermen. All rights reserved.
//

import UIKit

class MinhasReservas: UITableViewController {

    let SCREENSIZE: CGRect = UIScreen.mainScreen().bounds
    var _listaSectionTitles = NSArray()
    
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
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView {
        let containerView = NSBundle.mainBundle().loadNibNamed("ReservaTableViewHeader", owner: nil, options: nil)[0] as! ReservaTableViewHeader
        
        if section == 0{
            containerView.TextoHeader.text = "9 de fevereiro"
        }else{
            containerView.TextoHeader.text = "10 de fevereiro"
        }
        
        return containerView
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.registerNib(UINib(nibName: "MinhaReservaTableViewCell", bundle: nil), forCellReuseIdentifier: "MinhaReservaTableViewCell")
        let cell = tableView.dequeueReusableCellWithIdentifier("MinhaReservaTableViewCell", forIndexPath: indexPath) as! MinhaReservaTableViewCell
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(self.SCREENSIZE.width / 4.5)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.table?.deselectRowAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier("segueDetalhesReserva", sender: self)
    }
    
    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return 1
    }
    
}
