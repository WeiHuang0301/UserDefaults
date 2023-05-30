//
//  allDone_Page.swift
//  Alert Controller
//
//  Created by Wei Huang on 2023/5/25.
//  Copyright © 2023 WeiiH. All rights reserved.
//

import UIKit

class allDone_Page: UIViewController {
    
    @IBOutlet weak var backLogging: UIButton!
    @IBOutlet weak var userMsg: UILabel!
    
    // var accountData: UserDefaults!
    var firstName: String = ""
    var lastName: String = ""
    var userGenderIndex: Int! = nil
    var gender: String = ""
    var birthday: String = ""
    var id: String = ""
    var password: String = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if userGenderIndex == 0 {
            gender = "先生"
        } else if userGenderIndex == 1 {
            gender = "女士"
        }
        
        
        
        userMsg.text = "歡迎 \(firstName) \(lastName) \(gender)"
        
        
        
    }
    
    @IBAction func didTapped_backLogging(_ sender: UIButton) {
        print("個人資料：\(firstName), \(lastName), \(birthday), \(gender), \(id), \(password)")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            let firstName_si = segue.destination as! login_Page
            firstName_si.firstName_lo = firstName
            
            let lastName_si = segue.destination as! login_Page
            lastName_si.lastName_lo = lastName
            
            let gender_si = segue.destination as! login_Page
            gender_si.gender_lo = gender
            
            let birthday_si = segue.destination as! login_Page
            birthday_si.birthday_lo = birthday
            
            let id_si = segue.destination as! login_Page
            id_si.id_lo = id
            
            let password_si = segue.destination as! login_Page
            password_si.passward_lo = password
        let segue_ = segue.destination as! login_Page
        segue_.segue_ = false
            
        }
    
    
    
    
}
