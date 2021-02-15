//
//  ViewController.swift
//  AuthDemo3
//
//  Created by 永井佑磨 on 2021/02/13.
//

import UIKit
import Firebase

class ViewController: UIViewController{

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var onResisterButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        onResisterButton.layer.cornerRadius = 10
        emailTextField.delegate = self
        passwordTextField.delegate = self
        usernameTextField.delegate = self
        
        onResisterButton.isEnabled = false
        onResisterButton.backgroundColor = UIColor.rgb(red: 255, green: 221, blue: 187)
        
    }
    
    
    
    @IBAction func onResisterButton(_ sender: Any) {
        createAccount()
    }
    
    func createAccount(){
        guard let email = emailTextField.text else {return}
        guard  let password = passwordTextField.text else {return}
        guard let username = usernameTextField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password){
            (res,err) in
            if let err = err{
                print("情報の登録に失敗しました \(err)")
                return
            }
            print("情報の登録に成功しました")
            guard let uid = Auth.auth().currentUser?.uid else {return}
            let docData = ["email":email,"name":username,"createdAt":Timestamp()] as [String : Any]
            Firestore.firestore().collection("users").document(uid).setData(docData){
                (err) in
                if let err = err{
                    print("Firestoreへの保存に失敗しました\(err)")
                    return
                }
                print("Firestoreへの保存に成功しました")
            }
        }
    }
}
extension ViewController:UITextFieldDelegate{
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let emailIsEmpty = emailTextField.text?.isEmpty ?? true
        let passwordIsEmpty = passwordTextField.text?.isEmpty ?? true
        let usernameIsEmpty = usernameTextField.text?.isEmpty ?? true
        
        if emailIsEmpty || passwordIsEmpty || usernameIsEmpty{
            onResisterButton.isEnabled = false
            onResisterButton.backgroundColor = UIColor.rgb(red: 255, green: 221, blue: 187)
        }else {
            onResisterButton.isEnabled = true
            onResisterButton.backgroundColor = UIColor.rgb(red: 255, green: 141, blue: 0)
        }
        print("textField:",textField.text)
    }
}


