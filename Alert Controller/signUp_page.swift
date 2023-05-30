//
//  signUp_Page.swift
//  Alert Controller
//
//  Created by Wei Huang on 2023/5/25.
//  Copyright © 2023 WeiiH. All rights reserved.
//

import UIKit

class signUp_page: UIViewController, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var tf_firstName: UITextField!
    @IBOutlet weak var tf_lastName: UITextField!
    @IBOutlet weak var tf_birthday: UITextField!
    @IBOutlet weak var tf_id: UITextField!
    @IBOutlet weak var tf_password: UITextField!
    @IBOutlet weak var sc_gender: UISegmentedControl!
    
    @IBOutlet weak var haveAnAccount: UIButton!
    
    var selectGender = "unknow"
    var segueBackLogIn: Bool = false
    let account = UserDefaults()
    
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tf_firstName.delegate = self
        tf_lastName.delegate = self
        tf_birthday.delegate = self
        tf_id.delegate = self
        tf_password.delegate = self
        
        
    }
    
    @IBAction func haveAccountAction(_ sender: UIButton) {
        segueBackLogIn = true
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let firstName:String = checkInput(tf_firstName)
        let lastName = checkInput(tf_lastName)
        let birthday = checkInput(tf_birthday)
        let id = checkInput(tf_id)
        let password = checkInput(tf_password)
        if segueBackLogIn == true {
            return true
        }
        if firstName == "isEmpty" {
            return false
        }
        if lastName == "isEmpty" {
            return false
        }
        if birthday == "isEmpty" {
            return false
        }
        if id == "isEmpty" {
            return false
        }
        if password == "isEmpty" {
            return false
        }
        return true
    }
    
    func checkInput(_ textFill: UITextField) -> String {
        
        if segueBackLogIn == false {
            let alert = UIAlertController(title: "部分資料未填寫", message: "請輸入完整資料", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "確認", style: .default){
                (action) in print("didTappedCheck")
            }
            alert.addAction(alertAction)
            
            if textFill.text == "" {
                textFill.backgroundColor = UIColor(red: 246/255, green: 198/255, blue: 196/255, alpha: 90/100)
                present(alert, animated: true)
                return "isEmpty"
            }
        }
        return "0"
    }
    
    
    
    @IBAction func tapped_signUp(_ sender: UIButton) {
        
        
                account.set(tf_firstName.text, forKey: "key_firstName")
                account.set(tf_lastName.text, forKey: "key_lastName")
                account.set(tf_birthday.text, forKey: "key_birthday")
                account.set(tf_id.text, forKey: "key_id")
                account.set(tf_password.text, forKey: "key_password")
                account.synchronize()
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
            textField.backgroundColor = .systemGray6
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_signUpDone" {
            let firstName_si = segue.destination as! allDone_Page
            firstName_si.firstName = tf_firstName.text!
            
            let lastName_si = segue.destination as! allDone_Page
            lastName_si.lastName = tf_lastName.text!
            
            let gender_si = segue.destination as! allDone_Page
            gender_si.userGenderIndex = sc_gender.selectedSegmentIndex
            
            let birthday_si = segue.destination as! allDone_Page
            birthday_si.birthday = tf_birthday.text!
            
            let id_si = segue.destination as! allDone_Page
            id_si.id = tf_id.text!
            
            let password_si = segue.destination as! allDone_Page
            password_si.password = tf_password.text!
            
        }
    }
        
    
    }
    
    
    
    
    
    
    
    
    

