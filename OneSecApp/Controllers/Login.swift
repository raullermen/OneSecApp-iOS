//
//  Login.swift
//  OneSecApp
//
//  Created by Raul Lermen on 2/21/16.
//  Copyright © 2016 Raul Lermen. All rights reserved.
//

import UIKit

class Login: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        AjustaLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: LAYOUT
    func AjustaLayout(){
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.barTintColor = Util.AppVermelho()
        
        let font = UIFont(name: "GothamBold", size: 18.0)
        if let font = font {
            let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: font]
            self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : AnyObject]
        }
    }

}
