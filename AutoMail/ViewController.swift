//
//  ViewController.swift
//  AutoMail
//
//  Created by 岡本航輝 on 2017/02/22.
//  Copyright © 2017年 mycompany. All rights reserved.
//

import UIKit
import Foundation
class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var picker1: UIPickerView!
    @IBOutlet weak var receiver: UITextField!
    @IBOutlet weak var sender: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var text: UITextView!
    //@IBOutlet weak var time: UITextField!
    var dataList = ["@gmail.com","@yahoo.co.jp","other"]
    var fontArray = ["Zapfino","DBLCDTempBlack","MarkerFelt-Thin"]
    var host = "smtp.gmail.com"
    var hostdata = ["smtp.gmail.com","smtp.mail.yahoo.co.jp"]
    var flag=true
    var num=0
    var time=1
    let userDefaults=UserDefaults.standard
    var desplayS=""
    var desplayR=""
    var subject=""
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBAction func taptap(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    //コンポーネントに含まれるデータの個数を返すメソッド
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView.tag==0){
            return dataList.count
        }else{
            return 2000
        }
    }
    
    
    //データを返すメソッド
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView.tag==0){
            return dataList[row]
        }else{
            return String(row+1)
        }
    }
    
    
    //データ選択時の呼び出しメソッド
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(desplayR)
        print(desplayS)
        if(pickerView.tag==0){
            
        if(row==1){
            host="smtp.mail.yahoo.co.jp"
            print(host)
            flag=true
            num=1
        }else if(row==0){
            host="smtp.gmail.com"
            flag=true
            num=0
        }else{
            num=2
            if((userDefaults.string(forKey: "host")) != nil){
                host=userDefaults.string(forKey: "host")!
                
            }
            flag=false
        }
        }else if(pickerView.tag==1){
            time=row+1
        }
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        // 表示するラベルを生成する
        if(pickerView.tag==0){
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 50))
        label.textAlignment = .center
        label.text = dataList[row]
        label.font = UIFont(name: "MarkerFelt-Thin",size:16)
        label.textColor = .red
        return label
        }else{
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 50))
            label.textAlignment = .center
            label.text = String(row+1)
            label.font = UIFont(name: "MarkerFelt-Thin",size:16)
            label.textColor = .red
            return label
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.tag=0
        picker1.tag=1
        if((userDefaults.string(forKey: "host")) != nil){
            dataList[2]=userDefaults.string(forKey: "host")!
        }
        receiver.placeholder="write your e-mail adress"
        sender.placeholder="e-mail adress of receiver"
        password.placeholder="write your password of e-mail"
        //text.placeholser=""
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //let userDefaults = UserDefaults.standard
        if !userDefaults.bool(forKey: "do")==true{
            userDefaults.set(true, forKey: "do");
            let targetViewController = self.storyboard!.instantiateViewController( withIdentifier: "description" )
            //targetViewController.modalTransitionStyle=UIModalTransitionStyle.partialCurl
            self.present( targetViewController, animated: true, completion: nil)

        }
    }
    @IBAction func sousin(_ sender: Any) {
        let alert: UIAlertController = UIAlertController(title: "Caution", message: NSLocalizedString("Do you really sent this mail?",comment:""), preferredStyle:  UIAlertControllerStyle.alert)
        //let a=time.text
        // ② Actionの設定
        // Action初期化時にタイトル, スタイル, 押された時に実行されるハンドラを指定する
        // 第3引数のUIAlertActionStyleでボタンのスタイルを指定する
        // OKボタン
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            for _ in 0...self.time-1{
            let smtpSession=MCOSMTPSession()
            smtpSession.hostname = self.host//"smtp.gmail.com"
            if(self.num==2){
                smtpSession.username = self.userDefaults.string(forKey: "user")
            }else{
                smtpSession.username = self.sender.text! + self.dataList[self.num]
            }
            smtpSession.password = self.password.text
            smtpSession.port = 465
            smtpSession.authType = MCOAuthType.saslPlain
            smtpSession.connectionType = MCOConnectionType.TLS
            smtpSession.connectionLogger = {(connectionID, type, data) in
                if data != nil {
                    if let string = NSString(data: data!, encoding: String.Encoding.utf8.rawValue){
                        NSLog("Connectionlogger: \(string)")
                    }
                }
            }
            
            let builder = MCOMessageBuilder()
            builder.header.to = [MCOAddress(displayName: self.desplayR, mailbox: self.receiver.text)]
            if(self.num==2){
                builder.header.from = MCOAddress(displayName: self.desplayS, mailbox: self.userDefaults.string(forKey: "user"))
                    
            }else{
                builder.header.from = MCOAddress(displayName: self.desplayS, mailbox: self.sender.text! + self.dataList[self.num])
            }
            //builder.header.from = MCOAddress(displayName: "", mailbox: self.sender.text)
            builder.header.subject = ""
            builder.htmlBody = self.text.text
            
            let rfc822Data = builder.data()
            let sendOperation = smtpSession.sendOperation(with: rfc822Data)
            sendOperation?.start { (error) -> Void in
                if (error != nil) {
                    NSLog("Error sending email: \(error)")
                    let alert1: UIAlertController = UIAlertController(title: "Caution", message: NSLocalizedString("miss sending e-mail",comment:""), preferredStyle:  UIAlertControllerStyle.alert)
                    let missAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
                        (action: UIAlertAction!) -> Void in
                        
                    })
                    alert1.addAction(missAction)
                    self.present(alert1,animated: true, completion: nil)
                } else {
                    let alert2: UIAlertController = UIAlertController(title: "Caution", message: NSLocalizedString("Successfully sent email!",comment:""), preferredStyle:  UIAlertControllerStyle.alert)
                    let missAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
                        (action: UIAlertAction!) -> Void in
                        
                    })
                    alert2.addAction(missAction)
                    self.present(alert2,animated: true, completion: nil)
                    NSLog("Successfully sent email!")
                }
            }
            }
        })
        // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "cancel", style: UIAlertActionStyle.cancel, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            //print("Cancel")
        })
        
        // ③ UIAlertControllerにActionを追加
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        // ④ Alertを表示
        present(alert, animated: true, completion: nil)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
 

}

