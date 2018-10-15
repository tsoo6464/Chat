//
//  ViewController.swift
//  Chat
//
//  Created by Nan on 2018/10/15.
//  Copyright © 2018 nan. All rights reserved.
//

import UIKit
import Firebase

class AuthVC: UIViewController {
    //MARK: - Outlet & variable
    // Variables
    var status = Status.login
    // Outlets
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var subtitleLbl: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var switchBtn: UIButton!
    
    enum Status {
        case login
        case register
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if Auth.auth().currentUser != nil {
            dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func switchBtnPressed(_ sender: UIButton) {
        print(status)
        if status == .login {
            subtitleLbl.text = "請註冊帳號"
            submitBtn.setTitle("註冊", for: [])
            switchBtn.setTitle("已有帳號?", for: [])
            status = .register
        } else {
            subtitleLbl.text = "請登入帳號"
            submitBtn.setTitle("登入", for: [])
            switchBtn.setTitle("沒有帳號?", for: [])
            status = .login
        }
    }
    
    @IBAction func submitBtnPressed(_ sender: UIButton) {
        //檢查信箱跟密碼
        guard let email = emailTextfield.text, emailTextfield.text != "" else { return }
        guard let password = passwordTextfield.text, passwordTextfield.text != "" else { return }
        //判斷是登入還是註冊
        if status == .login {
            AuthService.instance.loginUser(withEmail: email, andPassword: password) { (success, error) in
                if let error = error {
                    print("錯誤代碼:\(error)")
                } else {
                    print("登入成功")
                    self.dismiss(animated: true, completion: nil)
                }
            }
        } else {
            AuthService.instance.registerUser(withEmail: email, andPassword: password) { (success, error) in
                if let error = error {
                    print("錯誤代碼:\(error)")
                } else {
                    print("註冊成功")
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        
    }
    
}

