//
//  startViewController.swift
//  AuthDemo3
//
//  Created by 永井佑磨 on 2021/02/20.
//

import UIKit
import Firebase

struct Entertainer {
    let name: String
    let age: String
    let image_url: String
    
    init(dic:[String:Any]) {
        self.name = dic["name"] as! String
        self.age = dic["age"] as! String
        self.image_url = dic["image_url"] as! String
    }
}

class startViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var ageLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Firestore.firestore().collection("entertainers").getDocuments{
            (snaps,err) in
            if let err = err{
                print("情報を取得することはできませんでした\(err)")
                return
            }
            guard let snaps = snaps else { return}
            for document in snaps.documents{
                print(document.data())
                let data = document.data()
                let entertainer = Entertainer.init(dic: data)
                self.ageLabel.text = entertainer.age
                self.nameButton.setTitle(entertainer.name, for: .normal)
            }
        }
        }
        


        
        // Do any additional setup after loading the view.
    
    
    @IBAction func onNameButton(_ sender: Any) {
       
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
