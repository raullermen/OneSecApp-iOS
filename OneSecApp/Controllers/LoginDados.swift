//
//  LoginDados.swift
//  OneSecApp
//
//  Created by Raul Lermen on 4/10/16.
//  Copyright © 2016 Raul Lermen. All rights reserved.
//

import UIKit

class LoginDados: UIViewController {
    
    @IBOutlet weak var ProfilePicture: UIView!
    
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
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        //Ajusta imagem do profile
        self.ProfilePicture.layer.cornerRadius = self.ProfilePicture.frame.size.width / 2
        self.ProfilePicture.clipsToBounds = true
        self.ProfilePicture.layer.borderWidth = 3.0
        self.ProfilePicture.layer.borderColor = Util.AppVermelho().CGColor
    }
    
}
