//
//  helpViewController.swift
//  
//
//  Created by 岡本航輝 on 2017/03/20.
//
//

import UIKit

class helpViewController: UIViewController {
    @IBOutlet weak var hostname: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var hostlabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    let userDefaults=UserDefaults.standard
    
    @IBAction func taptap(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    @IBAction func ok(_ sender: Any) {
        userDefaults.set(hostname.text,forKey: "host")
        userDefaults.set(username.text, forKey: "user")
        let targetViewController = self.storyboard!.instantiateViewController( withIdentifier: "view" )
        //targetViewController.modalTransitionStyle=UIModalTransitionStyle.partialCurl
        self.present( targetViewController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        hostlabel.textAlignment=NSTextAlignment.center
        userLabel.textAlignment=NSTextAlignment.center
        hostname.placeholder="example: smtp.gmail.com"
        username.placeholder="example: abc@gmail.com"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
