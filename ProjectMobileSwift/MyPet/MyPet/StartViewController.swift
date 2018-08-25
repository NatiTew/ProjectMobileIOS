//
//  StartViewController.swift
//  MyPet
//
//  Created by Natthaphon on 14/7/61.
//  Copyright © พ.ศ. 2561 Natthaphon. All rights reserved.
//

import UIKit
import SQLite


class StartViewController: UIViewController {
    var database: Connection!
    var database2: Connection!
    var database3: Connection!
    
    let usersTable = Table("petTest11")
    let systemTable = Table("petSys1")
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
    
    @IBOutlet var StartPic: UIImageView!
    @IBOutlet var StartBt: UIButton!
    @IBOutlet var MusicBt: UIButton!
    
    
    @IBAction func MusicAction(_ sender: Any) {
        
        MusicBt.setImage(UIImage(named: "redTap"), for: .normal)
        
    }
    @IBAction func StartAction(_ sender: Any) {
        createTable()
        createTableScene()
        
        print("Check status Login")
        
        do {
            let users = try self.database.prepare(self.systemTable)
            for user in users {
                if user[self.sysname] == "Login" {
                    if user[self.sysstatus] == true {
                        linkToMypet()
                    }
                    else{
                        linkToChoose()
                    }
                }
            }
        } catch {
            print("what error")
            print(error)
        }
        
    }
    
    func createTable() {
        print("create Tapped")
        let createTable = self.usersTable.create { (table) in
            table.column(self.chooseType, primaryKey: true)
            table.column(self.namePet)
            table.column(self.coin)
            table.column(self.statusHeart)
            table.column(self.staSceneHome)
            table.column(self.staSceneBath)
        }
        
        do{
            try self.database.run(createTable)
            print("Created Table")
        } catch{
            print(error)
        }
    }
    
    func createTableScene() {
        print("create Table Scene")
        let createSc = self.sceneTable.create { (table) in
            table.column(self.sceneName, primaryKey: true)
            table.column(self.sceneSta)
        }
        
        do{
            try self.database3.run(createSc)
            print("Created Scene Table")
        } catch{
            print(error)
        }
    }
    
    func linkToMypet() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextpage = storyboard.instantiateViewController(withIdentifier: "MyPet")
        
        self.present(nextpage,animated: true, completion: nil)
    }
    func linkToChoose() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextpage = storyboard.instantiateViewController(withIdentifier: "Choose")
        
        self.present(nextpage,animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        super.viewDidLoad()

        
        actiontransform()
        
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
        staSys()
        //let IntroImage = UIImage(named: "logo2")

        //StartPic.image = UIImage(named: "home2")
        //createTable()
        // Do any additional setup after loading the view.
    }
    
    func canRotate() -> Void {}
    
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
    
    func staSys() {
        let createTable = self.systemTable.create { (table) in
            table.column(self.sysname, primaryKey: true)
            table.column(self.sysstatus)
        }
        
        do {
            try self.database.run(createTable)
            print("sysCreated Table")
            insertSys()
        } catch {
            print(error)
            print("has data")
        }
        
    }
    
    func insertSys() {
        print("sysINSERT TAPPED")
        let namesta = "Login"
        let systemSta = false
        let insertUser = self.systemTable.insert(self.sysname <- namesta, self.sysstatus <- systemSta)
        
        do {
            try self.database.run(insertUser)
            print("sysINSERTED USER")
        } catch {
            
            print(error)
            print("sysError")
        }
    }
    
    func actiontransform() {
        StartBt.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 6.0,
                       options: .allowUserInteraction,
                       animations: { [weak self] in
                       self?.StartBt.transform = .identity
            }, completion: nil)
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
