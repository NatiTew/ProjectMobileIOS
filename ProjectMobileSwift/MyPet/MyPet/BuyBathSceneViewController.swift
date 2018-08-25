//
//  BuyBathSceneViewController.swift
//  MyPet
//
//  Created by Tanawadee Supraphakorn on 3/8/18.
//  Copyright © 2018 Natthaphon. All rights reserved.
//

import UIKit
import SQLite

class BuyBathSceneViewController: UIViewController {
    var database: Connection!
    var database3: Connection!
    
    let usersTable = Table("petTest11")
    let sceneTable = Table("petScene")
    
    let chooseType = Expression<Int>("chooseType")
    let sceneName = Expression<String>("sceneName")
    let sceneSta = Expression<Bool>("sceneSta")
    let coin = Expression<Int>("coin")
    
    @IBOutlet weak var bgSceneBuy: UIImageView!
    @IBOutlet weak var btNext: UIButton!
    @IBOutlet weak var btBack: UIButton!
    @IBOutlet weak var showCoin: UILabel!
    @IBOutlet weak var coin100: UIButton!
    
    
    var indexPic = 0
    let nameScene = [   0: "bathroom1",
                        1: "bathroom2",
                        2: "bathroom3",
                        3: "bathroom4"]
    
    @IBAction func nextPic(_ sender: Any) {
        indexPic = indexPic + 1
        loadPic()
    }
    @IBAction func backPic(_ sender: Any) {
        indexPic = indexPic - 1
        loadPic()
    }
    
    @IBAction func buy100(_ sender: Any) {
        priceScene()
    }
    
    func priceScene() {
        let coinScene: Int = 100
        
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                
                if user[self.coin] < coinScene{
                    let alert = UIAlertController(title: "แจ้งเตือน", message: "ยอดเงินของคุณไม่เพียงพอ", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "ตกลง", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
                else{
                    let payMoney = user[self.coin] - coinScene
                    
                    let id = self.usersTable.filter(self.chooseType == user[self.chooseType])
                    let updateMon = id.update(self.coin <- payMoney)
                    print("หักเงินสำเร็จ")
                    do {
                        print("Updte Mon")
                        try self.database.run(updateMon)
                        
                        let user1 = self.sceneTable.filter(self.sceneName == nameScene[indexPic]!)
                        let updateScene = user1.update(self.sceneSta <- true)
                        do {
                            print("อัพเดตซีน")
                            try self.database3.run(updateScene)
                            coin100.isHidden = true
                        } catch {
                            print("UpdateError")
                            print(error)
                        }
                        
                        
                    } catch {
                        print(error)
                    }
                    loadData()
                }
            }
        } catch {
            print("what error priceFood")
            print(error)
        }
    }
    
    
    func loadPic() {
        
        if indexPic == 0{
            btBack.isHidden = true
        }
        else{
            btBack.isHidden = false
        }
        
        if indexPic == 3{
            btNext.isHidden = true
        }
        else{
            btNext.isHidden = false
        }
        
        
        bgSceneBuy.image = UIImage(named: nameScene[indexPic]!)
        
        do {
            let users = try self.database3.prepare(self.sceneTable)
            for user in users {
                if user[self.sceneName] == nameScene[indexPic] {
                    if user[self.sceneSta] == true {
                        coin100.isHidden = true
                    }
                    else{
                        coin100.isHidden = false
                    }
                }
            }
        } catch {
            print("what error")
            print(error)
        }
        
        loadData()
        
    }
    
    
    override func viewDidLoad() {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let  fileUrl = documentDirectory.appendingPathComponent("petScene").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database3 = database
        } catch  {
            print(error)
        }
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let  fileUrl = documentDirectory.appendingPathComponent("petTest11").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch  {
            print(error)
        }
        super.viewDidLoad()
        
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        loadData()
        loadPic()
        indexPic = 0
        btBack.isHidden = true
        bgSceneBuy.image = UIImage(named: nameScene[indexPic]!)
    }
    
    func loadData() {
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                showCoin.text = String(user[self.coin])
            }
        } catch {
            print("what error")
            print(error)
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
