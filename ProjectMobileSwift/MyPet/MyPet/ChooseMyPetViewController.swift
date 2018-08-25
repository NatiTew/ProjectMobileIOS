//
//  ChooseMyPetViewController.swift
//  MyPet
//
//  Created by Natthaphon on 14/7/61.
//  Copyright © พ.ศ. 2561 Natthaphon. All rights reserved.
//

import UIKit
import SQLite


class ChooseMyPetViewController: UIViewController {
    
    @IBOutlet weak var bgChoose: UILabel!
    @IBOutlet weak var bgMainChoose: UIImageView!
    @IBOutlet weak var backToChoose: UIStackView!
    @IBOutlet weak var goToMyPet: UIButton!
    @IBOutlet weak var textName: UITextField!
    
    @IBOutlet weak var BGlock: UIView!
    
    
    var database:Connection!
    var database2: Connection!
    var database3: Connection!
    
    let systemTable = Table("petSys1")
    let usersTable = Table("petTest11")
    let sceneTable = Table("petScene")
    
    let sceneName = Expression<String>("sceneName")
    let sceneSta = Expression<Bool>("sceneSta")
    
    let sysname = Expression<String>("name")
    let sysstatus = Expression<Bool>("status")
    
    let chooseType = Expression<Int>("chooseType")
    let namePet = Expression<String>("namePet")
    let coin = Expression<Int>("coin")
    let statusHeart = Expression<Int>("statusHeart")
    let staSceneHome = Expression<String>("staSceneHome")
    let staSceneBath = Expression<String>("staSceneBath")
    var typePet:Int!
    
    let nameScene = [   0: "gardent1",
                        1: "gardent2",
                        2: "kitchen2",
                        3: "kitchen4",
                        4: "livingroom2",
                        5: "livingroom3",
                        6: "livingroom4",
                        7: "bathroom1",
                        8: "bathroom2",
                        9: "bathroom3"]
    
    @IBAction func backToStart(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextpage = storyboard.instantiateViewController(withIdentifier: "Start")
        
        self.present(nextpage,animated: true, completion: nil)
    }
  
    @IBAction func catChoose(_ sender: UIButton) {
        typePet = 1
        sender.popIn()
        print("goToNaming cat")
        naxtToNaming()
    }
  
    @IBAction func dogChoose(_ sender: UIButton) {
        typePet = 3
        sender.popIn()
        print("goToNaming dog")
        naxtToNaming()
    }
    
    @IBAction func panChoose(_ sender: UIButton) {
        typePet = 2
        sender.popIn()
        print("goToNaming pan")
        naxtToNaming()
    }
    
    @IBAction func pinChoose(_ sender: UIButton) {
        typePet = 4
        sender.popIn()
        print("goToNaming pin")
        naxtToNaming()
    }
    
    func naxtToNaming() {
        bgChoose.isHidden = false
        bgMainChoose.isHidden = false
        backToChoose.isHidden = false
        goToMyPet.isHidden = false
        textName.isHidden = false
        BGlock.isHidden = false

    }
    
    @IBAction func linkToMypet(_ sender: Any) {
        
        if (textName.text?.isEmpty)!{
            let alert = UIAlertController(title: "แจ้งเตือน", message: "กรุณากรอกชื่อ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "รับทราบ", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        else{
            
            let setName = textName.text
            print("Show " + setName!)
            let setCoin: Int = 400
            let  setStatusHea: Int = 30
            
            let insertUser = self.usersTable.insert(self.chooseType <- typePet, self.namePet <- setName!, self.coin <- setCoin, self.statusHeart <- setStatusHea, self.staSceneHome <- "liviingSet", self.staSceneBath <- "bathscene")
            do{
                try self.database.run(insertUser)
                let nameChang = "Login"
                let staChang = true
                
                print("up")
                
                let user = self.systemTable.filter(self.sysname == nameChang)
                let updateUser = user.update(self.sysstatus <- staChang)
                do {
                    print("UpdateOk")
                    try self.database.run(updateUser)
                } catch {
                    print("UpdateError")
                    print(error)
                }
                
                let insertScene2 = self.sceneTable.insert(self.sceneName <- "defaultHome", self.sceneSta <- true)
                do{
                    try self.database3.run(insertScene2)
                    print("add name defaultHome")
                } catch{
                    print("Error name defaultHome")
                    print(error)
                }
                let insertScene1 = self.sceneTable.insert(self.sceneName <- "defaultBath", self.sceneSta <- true)
                do{
                    try self.database3.run(insertScene1)
                    print("add name defaultBath")
                } catch{
                    print("Error name defaultBath")
                    print(error)
                }
                
                for i in 0 ... 9
                {
                    let insertScene = self.sceneTable.insert(self.sceneName <- nameScene[i]!, self.sceneSta <- false)
                    do{
                        try self.database3.run(insertScene)
                        print("add name scene")
                    } catch{
                        print("Error name scene")
                        print(error)
                    }
                }

                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let nextpage = storyboard.instantiateViewController(withIdentifier: "MyPet")
                
                self.present(nextpage,animated: true, completion: nil)
            } catch{
                print(error)
            }
        }
    }
    
    @IBAction func linkToChoose(_ sender: Any) {
        print("goToChoose")
        bgChoose.isHidden = true
        bgMainChoose.isHidden = true
        backToChoose.isHidden = true
        goToMyPet.isHidden = true
        textName.isHidden = true
        BGlock.isHidden = true
        typePet = 0
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let  fileUrl = documentDirectory.appendingPathComponent("petTest11").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch  {
            print(error)
        }
        
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let  fileUrl = documentDirectory.appendingPathComponent("petScene").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database3 = database
        } catch  {
            print(error)
        }
        
        sysTable()
        

        // Do any additional setup after loading the view.
    }
    
    func sysTable() {
        do {
            let documentDirectory2 = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory2.appendingPathComponent("petSys1").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database2 = database
        } catch {
            print(error)
            print("sysError")
        }
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
