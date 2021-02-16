//
//  homeViewController.swift
//  AuthDemo3
//
//  Created by 永井佑磨 on 2021/02/15.
//

import UIKit

class homeViewController: UIViewController {

    
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
    
    var outPutName :String?
    var outPutEmail :String?
    var outPutDate :MTLTimestamp?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        logOutButton.layer.cornerRadius = 10
        nameLabel.text = outPutName  
        emailLabel.text = outPutEmail
        dateLabel.text = outPutEmail
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
