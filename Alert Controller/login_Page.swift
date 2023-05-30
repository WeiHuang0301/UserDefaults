//
//  login_page.swift
//  Alert Controller
//
//  Created by Wei Huang on 2023/5/25.
//  Copyright © 2023 WeiiH. All rights reserved.
//

import UIKit

class login_Page: UIViewController, UITextFieldDelegate {
    
    var firstName_lo: String = ""
    var lastName_lo: String = ""
    var gender_lo: String = ""
    var birthday_lo: String = ""
    var id_lo: String = ""
    var passward_lo: String = ""
    
    var segueLogIn: Bool = true
    var segue_: Bool = false
    
    @IBOutlet weak var tf_idLogin: UITextField!
    @IBOutlet weak var tf_passwordLogin: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tf_idLogin.delegate = self
        tf_passwordLogin.delegate = self
        print("id: \(id_lo), Pass:\(passward_lo)")
    
    }
    
    @IBAction func didTappedSignUp(_ sender: UIButton) {
        segue_ = true
        print("Signup")
    }
    
    @IBAction func tapped_Login (_ sender: UIButton) {
        segue_ = false
        print("Login")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
            textField.backgroundColor = .systemGray6
        }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let idCheck: String = checkLogin(tf_idLogin)
        let passwordCheck: String = checkLogin(tf_passwordLogin)
        if segue_ == true {
            print ("segue")
            return true
            
        } else {
            if idCheck == "isEmpty" {
                return false
            }
            if passwordCheck == "isEmpty" {
                return false
            }
            if idCheck == "Incorrect" {
                return false
            }
            if passwordCheck == "Incorrect" {
                return false
            }
        }
        return true
    }
    
    
    
    
    @IBAction func unwindLogin(for segue: UIStoryboardSegue) {
    }
    
    func checkLogin(_ textFill: UITextField) -> String {

           // alert 訊息設置: Not Field
        let alert_notField = UIAlertController(title: "部分資料未填寫", message: "請輸入完整資料", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "確認", style: .default){
                   (action) in print("didTappedCheck") //確認後 action
            }
        alert_notField.addAction(alertAction)
        
        // alert 訊息: id incorrect
        let alert_idIncorrect = UIAlertController(title: "找不到您的帳戶", message: "請再試一次", preferredStyle: .alert)
        alert_idIncorrect.addAction(alertAction)
        
        // alert 訊息: password incorrect
        let alert_passwordIncorrect = UIAlertController(title: "密碼錯誤", message: "請輸入正確密碼", preferredStyle: .alert)
        alert_passwordIncorrect.addAction(alertAction)
        
        
        if segue_ == false {
            // 輸入欄未填
            if textFill.text == "" {
                textFill.backgroundColor = UIColor(red: 246/255, green: 198/255, blue: 196/255, alpha: 90/100)
                present(alert_notField, animated: true) // 呼叫alert
                return "isEmpty" // func result
            }
            
            if tf_idLogin.text != id_lo {
                present(alert_idIncorrect, animated: true)
                print("idIncorrect")
                return "Incorrect"
                
            }
            if tf_passwordLogin.text != passward_lo {
                present(alert_passwordIncorrect, animated: true)
                print("passwordIncorrect")
                return "Incorrect"
                
            }
        }
        return "correct"
    }
    
    
       
    }
    
    
    
    
    

