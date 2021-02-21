//
//  demo1ViewController.swift
//  AuthDemo3
//
//  Created by 永井佑磨 on 2021/02/21.
//

import UIKit
import Firebase



struct Entertainr {
    let name: String
    let age: String
    let image_url :String
    
    init(dic:[String:Any]) {
        self.name = dic["name"] as! String
        self.age = dic["age"] as! String
        self.image_url = dic["age"] as! String
    }
}

class demo1ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
   
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "entertainerCell",for: indexPath)
        Firestore.firestore().collection("entertainers").getDocuments{
            (snaps,err) in
            if let err = err{
                print("ユーザー情報を取得できていません\(err)")
                return
            }
            guard let snaps = snaps else {return}
            for document in snaps.documents{
                print(document.data())
                cell.textLabel?.text = document[indexPath.row] as? String
            }
            
        }
        
    }
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
