//
//  ViewController.swift
//  AuthDemo3
//
//  Created by 永井佑磨 on 2021/02/13.
//

import UIKit
import Firebase
import PKHUD
struct User {
    let name:String
    let createdAt:Timestamp
    let email:String
    
    init(dic:[String:Any]) {
        self.name = dic["name"] as! String
        self.createdAt = dic["createdAt"] as! Timestamp
        self.email = dic["email"] as! String
    }
}
class ViewController: UIViewController{
    var delegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
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
        HUD.show(.progress,onView: view)
        guard let email = emailTextField.text else {return}
        guard  let password = passwordTextField.text else {return}
       
        
        Auth.auth().createUser(withEmail: email, password: password){
            (res,err) in
            if let err = err{
                print("情報の登録に失敗しました \(err)")
                return
                    HUD.hide{(_) in
                        HUD.flash(.error,delay: 1)
                    }
            }
            print("情報の登録に成功しました")
            self.addUserInfoToFirebase(email: email)
        }
    }
    func addUserInfoToFirebase(email:String){
    guard let username = usernameTextField.text else { return }
    guard let uid = Auth.auth().currentUser?.uid else {return}
    guard let email = emailTextField.text else {return}
        
        
        
    let docData = ["email":email,"name":username,"createdAt":Timestamp()] as [String : Any]
    let userRef = Firestore.firestore().collection("users").document(uid)
        userRef.setData(docData){
            (err) in
            if let err = err{
                print("Firestoreへの保存に失敗しました\(err)")
                return
                    HUD.hide{(_) in
                        HUD.flash(.error,delay: 1)
                    }
            }
            print("Firestoreへの保存に成功しました")
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
                nextVC.outPutName = username
                nextVC.outPutEmail = email
                self.present(nextVC, animated: true, completion: nil)
            }
             func confirmLoggerdInUser(){
                if Auth.auth().currentUser?.uid == nil {
                    self.performSegue(withIdentifier: "ViewController" , sender: nil)
                }
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
