//
//  LoginViewController.swift
//  AuthDemo3
//
//  Created by 永井佑磨 on 2021/02/17.
//

import UIKit
import Firebase
import PKHUD

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var onResisterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onResisterButton.layer.cornerRadius = 10
        emailTextField.delegate = self
        passwordTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onResisterButton(_ sender: Any) {
        HUD.show(.progress,onView: self.view)
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        let userRef = Firestore.firestore().collection("users").document(uid)
        
        Auth.auth().signIn(withEmail: email, password: password){
            (res,err) in
            if let err = err{
                print("ログイン情報の取得に失敗しました\(err)")
                return
            }
            print("ログインに成功しました")
            userRef.getDocument{ [self]
                (snapshot,err) in
                if let err = err{
                    print("ユーザー情報の取得に失敗しました\(err)")
                    return
                        HUD.hide{(_) in
                            HUD.flash(.error,delay: 1)
                        }
                }
                guard let data = snapshot?.data() else {return}
                
                let user = User.init(dic: data)
                print("ユーザー情報の取得に成功しました\(user.name)")
                HUD.hide{(_) in
                    HUD.flash(.success, onView: self.view, delay: 1){(_) in
                    }
                }
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "welcome") as! homeViewController
                nextVC.outPutEmail = email
                self.present(nextVC, animated: true, completion: nil)
            }
        }
    }
}

extension LoginViewController: UITextFieldDelegate{
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let emailIsEmpty = emailTextField.text?.isEmpty ?? true
        let passwordIsEmpty = passwordTextField.text?.isEmpty ?? true
        
        if emailIsEmpty || passwordIsEmpty {
            onResisterButton.isEnabled = false
            onResisterButton.backgroundColor = UIColor.rgb(red: 255, green: 221, blue: 187)
        }else {
            onResisterButton.isEnabled = true
            onResisterButton.backgroundColor = UIColor.rgb(red: 255, green: 141, blue: 0)
        }
        print("textField:",textField.text)
        
    }
}
