//
//  guideViewController.swift
//  
//
//  Created by 岡本航輝 on 2017/03/24.
//
//

import UIKit

class guideViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let prefLang = NSLocale.preferredLanguages.first! as String
        let locale = NSLocale.current
        //let languageCode = locale.objectForKey(NSLocaleLanguageCode) as! String
        let langs = ["ja-JP", "ja-US", "en-JP", "en-US", "it-IT"]
        //for (lang) in langs.enumerated() {
            if prefLang.hasPrefix("ja") {
                self.image.image = UIImage(named: "IMG_5054.JPG")
                //print(lang, "日本語")
            } else if prefLang.hasPrefix("en") {
                self.image.image = UIImage(named: "IMG_5050.JPG")
                //print(lang, "英語")
            } else {
                //print(lang, "未知の言語")
            }
       // }
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
