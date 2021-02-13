//
//  ViewController.swift
//  AuthDemo3
//
//  Created by 永井佑磨 on 2021/02/13.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var onResisterButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        onResisterButton.layer.cornerRadius = 10
       
    }


}
