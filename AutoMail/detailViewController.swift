//
//  detailViewController.swift
//  AutoMail
//
//  Created by 岡本航輝 on 2017/03/22.
//  Copyright © 2017年 mycompany. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {

    @IBOutlet weak var senderName: UITextField!
    @IBOutlet weak var receiverName: UITextField!
    @IBOutlet weak var subject: UITextField!
    @IBAction func taptap(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func ok(_ sender: Any) {
        let targetViewController = self.storyboard!.instantiateViewController( withIdentifier: "view" )
        //targetViewController.modalTransitionStyle=UIModalTransitionStyle.partialCurl
        let viewcontroller=targetViewController as! ViewController
        viewcontroller.desplayS=senderName.text!
        viewcontroller.desplayR=receiverName.text!
        viewcontroller.subject=subject.text!
        self.present( targetViewController, animated: true, completion: nil)
    }
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewcontroller=segue.destination as! ViewController
        viewcontroller.desplayS=senderName.text!
        viewcontroller.desplayR=receiverName.text!
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
