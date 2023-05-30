//
//  ViewController.swift
//  Alert Controller
//
//  Created by mac on 2023/5/23.
//  Copyright © 2023年 WeiiH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    @IBOutlet weak var callActionSheet: UIButton!
    @IBOutlet weak var callAlert: UIButton!
    @IBAction func Login(_ sender: UIButton) {
    }
    
    
    
    @IBAction func tabCallActionSheet(_ sender: UIButton) {
        // The alertController has two style: .alert or .actionSheet
        let alertController = UIAlertController(
            title: "Action Sheet",
            message: "We found you've tapped the button, need help?",
            preferredStyle: .actionSheet)
        
        // 宣告一個『叫siri』按鈕
        let okAction = UIAlertAction(title: "Call siri", style: .default)
        { (action) in
            // the button action whrite down here.
        }
        // 將確定鈕加進 UIAlertController
        alertController.addAction(okAction)
        
        // 顯示訊息匡
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func alertTrigger(_ sender: UIButton) {
        let alertController = UIAlertController(
            title: "Alert",
            message: "We found you've tapped the button, need help?",
            preferredStyle: .alert)
        
        // 宣告一個『叫siri』按鈕
        let alertAction = UIAlertAction(title: "Call siri", style: .default)
        { (action) in
            // the button action whrite down here.
        }
        // 將確定鈕加進 UIAlertController
        alertController.addAction(alertAction)
        
        // 顯示訊息匡
        present(alertController, animated: true, completion: nil)
    }
        
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

