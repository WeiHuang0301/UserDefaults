//
//  foldManage_Page.swift
//  Alert Controller
//
//  Created by Wei Huang on 2023/5/29.
//  Copyright © 2023 WeiiH. All rights reserved.
//

import UIKit

class foldManage_Page: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
   
    var files_A = [String]()
    var files_B = [String]()
    
    @IBOutlet weak var tf_named: UITextField!
    @IBOutlet weak var btn_create: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    // 設定工作目錄
    let fileManager = FileManager.default
    // 設定存檔路徑
    let path_A = NSHomeDirectory() + "/Documents"
    let path_B = NSHomeDirectory() + "/tmp"
    
    
    // table view 區域
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // 各 section 的 rows 設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // File A
        if section == 0 {
            return files_A.count
        }
        // File B
        if section == 1 {
            return files_B.count
        }
        return 0
    }
    
    // Section header title 設定
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //
        if section == 0 {
            return "Document"
        }
        if section == 1 {
            return "tmp"
        }
        return ""
    }
    
    // cell (in Section) 自動新增（數檔案）設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!

        if indexPath.section == 0 {
            cell.textLabel?.text = files_A[indexPath.row]
        }
        if indexPath.section == 1 {
            cell.textLabel?.text = files_B[indexPath.row]
        }
        return cell
    }
    
    // func: 按下cell 編輯
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fileEdit = UIAlertController(title:"編輯檔案" , message: "對該 file 執行：", preferredStyle: .alert)
        let fileAct_Move = UIAlertAction(title: "Move", style: .default){
            (action) in self.moveFile()
            self.handleRefresh()
        }
        let fileAct_Copy = UIAlertAction(title: "Duplicate", style: .default){
            (action) in
            if indexPath.section == 0 {
                self.copyFile(name: self.files_A[indexPath.row])
            }else {
                self.copyFile(name: self.files_B[indexPath.row])
            }
        }
        fileEdit.addAction(fileAct_Copy)
        fileEdit.addAction(fileAct_Move)
        present(fileEdit, animated: true)
    }
    
    
    // TextField 輸入時 變回預設色彩
    func textFieldDidBeginEditing(_ textField: UITextField) {
            textField.backgroundColor = .systemGray6
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var curn:String
        var dest: String
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)

        // 建立 txt檔 在 Documents
        
       loadfiles() // 刷新 func
        /* curn = path_A + "/diary.txt" VV */
    }
    
    
    // func 流程： ccheck
    
    func checkFileName(_ textfield: UITextField ) -> String {
        
        let alert_fileName = UIAlertController(title: "檔案未命名", message: "請重新鍵入檔名", preferredStyle: .actionSheet)
        let alertAction = UIAlertAction(title: "確認", style: .default)
        alert_fileName.addAction(alertAction)
        
        if textfield.text == "" {
            textfield.backgroundColor = UIColor(red: 246/255, green: 198/255, blue: 196/255, alpha: 90/100)
            present(alert_fileName, animated: true)
            return "isEmpty"
        }
        return textfield.text!
    }
    
    func createFile( path: String, fileName: String ) {
        
        
        let data = "It's a lost diary... ".data(using: .utf8)
        
        if fileManager.createFile(atPath: path + "/\(fileName).txt", contents: data, attributes: nil) {
            print("create file: Success!!")
        } else {
            print("create Failed.")
        }
    }
    
    func moveFile() {
        var curt: String
        var dest: String
        if fileManager.fileExists(atPath: path_A) {
           curt = path_A
           dest = path_B
        } else {
            curt = path_B
            dest = path_A
        }
        
        do {
            try fileManager.moveItem(atPath: curt, toPath: dest )
            print("Move Success")
        } catch {
            print("Move Failed")
        }
    }
    
    func copyFile(name: String) {
        
        let copyDestnation = UIAlertController(title: "複製目的地？", message: "Choose a destination for the duplicate.", preferredStyle: .alert)
        
        let dest_Documents = UIAlertAction(title: "Ducuments", style: .default){
            (action) in
            var curt: String = ""
            let dest = "\(self.path_B)/\(name)"
           
            if self.fileManager.fileExists(atPath: "\(self.path_A)/\(name)") {
                curt = "\(self.path_A)/\(name)"
               // dest = "\(path_B)/\(name)"
            
            } else {
                curt = "\(self.path_B)/\(name)"
                // dest = "\(path_A)/\(name)"
            }
            
            do {
                try self.fileManager.copyItem(atPath: curt, toPath: dest )
                print("Duplicate Success")
            } catch {
                print("Duplicate Failed")
            }
            self.handleRefresh()
        }
        
        // -------------------- tmp --------------------------
        let dest_tmp = UIAlertAction(title: "tmp", style: .default){
            (action) in
            var curt: String = ""
            let dest = "\(self.path_A)/\(name)"
            
            if self.fileManager.fileExists(atPath: "\(self.path_A)/\(name)") {
                curt = "\(self.path_A)/\(name)"
               // dest = "\(path_B)/\(name)"
            
            } else {
                curt = "\(self.path_B)/\(name)"
                // dest = "\(path_A)/\(name)"
            }
            
            do {
                try self.fileManager.copyItem(atPath: curt, toPath: dest )
                print("Duplicate Success")
            } catch {
                print("Duplicate Failed")
            }
            self.handleRefresh()
        }
        copyDestnation.addAction(dest_Documents)
        copyDestnation.addAction(dest_tmp)
        present(copyDestnation, animated: true)
        
        
    }
    
    
    
    // ---------------------------------------
    
    func loadfiles() {
        // 讀取 files 數目 in fold
        do {
           files_A = try fileManager.contentsOfDirectory(atPath: "\(NSHomeDirectory())/Documents")
        } catch {
            print("'Documents Not Found'")
        }
        do {
           files_B = try fileManager.contentsOfDirectory(atPath: "\(NSHomeDirectory())/tmp")
        } catch {
            print("'tmp Not Found'")
        }
    }
    
    @objc func handleRefresh() {
        loadfiles()
        tableView.refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    
    // 按下[Create] 按鈕後，執行alert_pathSelect: 選擇路徑後 觸發func: {createFile}
    // -----------------------------
    @IBAction func didTappedCreate(_ sender: UIButton) {
        
        let fileNameInput = checkFileName(tf_named)
        if fileNameInput == "isEmpty"{
            return
        }

        let alert_pathSelect = UIAlertController(title: "Choose a path", message: "選擇欲新增的檔案夾", preferredStyle: .alert)
        let alertSection_pathA = UIAlertAction(title: "Documents", style: .default){
                   (action) in self.createFile(path: self.path_A, fileName: fileNameInput) // 呼叫並帶入摻數(path, fileName)
            self.handleRefresh() //確認後 action
            }
        alert_pathSelect.addAction(alertSection_pathA)
        
        let alertSection_pathB = UIAlertAction(title: "tmp", style: .default){
            (action) in self.createFile(path: self.path_B, fileName: fileNameInput)
            self.handleRefresh() //確認後 action
            }
        alert_pathSelect.addAction(alertSection_pathB)
        
        present(alert_pathSelect, animated: true)
        
    }
    
    
    
}
