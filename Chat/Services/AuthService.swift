//
//  AuthService.swift
//  Chat
//
//  Created by Nan on 2018/10/15.
//  Copyright © 2018 nan. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    static let instance = AuthService()
    //MARK: - 帳號註冊登入方法
    func registerUser(withEmail email: String, andPassword password: String, completion: @escaping (_ success: Bool, _ error: Error?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (User, Error) in
            
            guard let user = User?.user else {
                completion(false, Error)
                return
            }
            
            let userData = ["provider" : user.providerID, "email" : user.email!, "image" : "defaultProfileImage"]
            DataService.instance.createDBUser(uid: user.uid, userData: userData)
            
            completion(true, nil)
        }
    }
    // 登入
    func loginUser(withEmail email: String, andPassword password: String, completion: @escaping (_ success: Bool, _ error: Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (User, Error) in
            if Error != nil {
                completion(false, Error)
                return
            }
            completion(true, nil)
        }
    }
}
