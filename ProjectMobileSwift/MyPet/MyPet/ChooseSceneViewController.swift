//
//  ChooseSceneViewController.swift
//  MyPet
//
//  Created by NatiTew Munpholsri on 30/7/61.
//  Copyright © พ.ศ. 2561 Natthaphon. All rights reserved.
//

import UIKit
import SQLite

class ChooseSceneViewController: UIViewController {
    
    var database: Connection!
    var database3: Connection!
    
    let usersTable = Table("petTest11")
    let sceneTable = Table("petScene")
    
    
    let sceneName = Expression<String>("sceneName")
    let sceneSta = Expression<Bool>("sceneSta")
    
    let chooseType = Expression<Int>("chooseType")
    let staSceneHome = Expression<String>("staSceneHome")
    let staSceneBath = Expression<String>("staSceneBath")
    
    @IBOutlet weak var tableLiving: UIStackView!
    @IBOutlet weak var tableBath: UIStackView!
    @IBOutlet weak var bathBt: UIButton!
    @IBOutlet weak var livingBt: UIButton!
    @IBOutlet weak var btL1: UIButton!
    @IBOutlet weak var btL2: UIButton!
    @IBOutlet weak var btL3: UIButton!
    @IBOutlet weak var btL4: UIButton!
    @IBOutlet weak var btL5: UIButton!
    @IBOutlet weak var btL6: UIButton!
    @IBOutlet weak var btL7: UIButton!
    @IBOutlet weak var btB1: UIButton!
    @IBOutlet weak var btB2: UIButton!
    @IBOutlet weak var btB3: UIButton!
    @IBOutlet weak var btB4: UIButton!
    @IBOutlet weak var cP0: UIImageView!
    @IBOutlet weak var cP1: UIImageView!
    @IBOutlet weak var cP2: UIImageView!
    @IBOutlet weak var cp3: UIImageView!
    @IBOutlet weak var cP4: UIImageView!
    @IBOutlet weak var cP5: UIImageView!
    @IBOutlet weak var cP6: UIImageView!
    @IBOutlet weak var cP7: UIImageView!
    
    let nameSceneLiving = [ 1: "gardent1",
                            2: "gardent2",
                            3: "kitchen2",
                            4: "kitchen4",
                            5: "livingroom2",
                            6: "livingroom3",
                            7: "livingroom4"]
    
    let nameSceneL = [ "gardent1": 1,
                       "gardent2": 2,
                       "kitchen2": 3,
                       "kitchen4": 4,
                       "livingroom2": 5,
                       "livingroom3": 6,
                       "livingroom4": 7]
    
    let nameSceneBath = [   1: "bathroom1",
                            2: "bathroom2",
                            3: "bathroom3"]
    
    let nameSceneB = [  "bathroom1": 1,
                        "bathroom2": 2,
                        "bathroom3": 3]
    
    @IBAction func chooseLiving(_ sender: Any) {
        livingBt.backgroundColor = UIColor.yellow
        bathBt.backgroundColor = UIColor.black
        tableLiving.isHidden = false
        tableBath.isHidden = true
        rePoint()
        loadPointHome()
        //loadPointBath()
    }
    @IBAction func chooseBath(_ sender: Any) {
        livingBt.backgroundColor = UIColor.black
        bathBt.backgroundColor = UIColor.yellow
        tableLiving.isHidden = true
        tableBath.isHidden = false
        rePoint()
        //loadPointHome()
        loadPointBath()
    }
    @IBAction func clickL0(_ sender: Any) {
        let location = 0
        changePointH(bt: location)
        rePoint()
        loadPointHome()
    }
    @IBAction func clickL1(_ sender: Any) {
        let location = 1
        homeCheck(num: location)
    }
    @IBAction func clickL2(_ sender: Any) {
        let location = 2
        homeCheck(num: location)
    }
    @IBAction func clickL3(_ sender: Any) {
        let location = 3
        homeCheck(num: location)
    }
    @IBAction func clickL4(_ sender: Any) {
        let location = 4
        homeCheck(num: location)
    }
    @IBAction func clickL5(_ sender: Any) {
        let location = 5
        homeCheck(num: location)
    }
    @IBAction func clickL6(_ sender: Any) {
        let location = 6
        homeCheck(num: location)
    }
    @IBAction func clickL7(_ sender: Any) {
        let location = 7
        homeCheck(num: location)
    }
    
    
    @IBAction func clickB0(_ sender: Any) {
        let location = 0
        changePointB(bt: location)
        rePoint()
        loadPointBath()
        
    }
    @IBAction func clickB1(_ sender: Any) {
        let location = 1
        bathCheck(num: location)
    }
    @IBAction func clickB2(_ sender: Any) {
        let location = 2
        bathCheck(num: location)
    }
    @IBAction func clickB3(_ sender: Any) {
        let location = 3
        bathCheck(num: location)
    }
    
    func homeCheck(num: Int){
        do {
            let users = try self.database3.prepare(self.sceneTable)
            for user in users {
                if user[self.sceneName] == nameSceneLiving[num] {
                    if user[self.sceneSta] == true {
                        changePointH(bt: num)
                        rePoint()
                        loadPointHome()
                    }
                }
            }
        } catch {
            print("what error")
            print(error)
        }
    }
    func bathCheck(num: Int){
        do {
            let users = try self.database3.prepare(self.sceneTable)
            for user in users {
                if user[self.sceneName] == nameSceneBath[num] {
                    if user[self.sceneSta] == true {
                        changePointB(bt: num)
                        rePoint()
                        loadPointBath()
                    }
                }
            }
        } catch {
            print("what error")
            print(error)
        }
    }
    
    func changePointH(bt: Int) {
        
        if bt == 0 {
            do {
                let users = try self.database.prepare(self.usersTable)
                for user in users {
                    let user1 = self.usersTable.filter(self.chooseType == user[self.chooseType])
                    let updateSta = user1.update(self.staSceneHome <- "liviingSet" )
                    do {
                        try self.database.run(updateSta)
                    } catch {
                        print("UpdateError")
                        print(error)
                    }
                }
            } catch {
                print("what error")
                print(error)
            }
        }
        else{
            do {
                let users = try self.database.prepare(self.usersTable)
                for user in users {
                    let user1 = self.usersTable.filter(self.chooseType == user[self.chooseType])
                    let updateSta = user1.update(self.staSceneHome <- nameSceneLiving[bt]! )
                    do {
                        try self.database.run(updateSta)
                    } catch {
                        print("UpdateError")
                        print(error)
                    }
                }
            } catch {
                print("what error")
                print(error)
            }
        }
   
    }
    func changePointB(bt: Int) {
        if bt == 0 {
            do {
                let users = try self.database.prepare(self.usersTable)
                for user in users {
                    let user1 = self.usersTable.filter(self.chooseType == user[self.chooseType])
                    let updateSta = user1.update(self.staSceneBath <- "bathscene" )
                    do {
                        try self.database.run(updateSta)
                    } catch {
                        print("UpdateError")
                        print(error)
                    }
                }
            } catch {
                print("what error")
                print(error)
            }
        }
        else{
            do {
                let users = try self.database.prepare(self.usersTable)
                for user in users {
                    let user1 = self.usersTable.filter(self.chooseType == user[self.chooseType])
                    let updateSta = user1.update(self.staSceneBath <- nameSceneBath[bt]! )
                    do {
                        try self.database.run(updateSta)
                    } catch {
                        print("UpdateError")
                        print(error)
                    }
                }
            } catch {
                print("what error")
                print(error)
            }
        }
        
    }
    

    override func viewDidLoad() {
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
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
        loadData()
        rePoint()
        loadPointHome()
        //loadPointBath()

        // Do any additional setup after loading the view.
    }
    
    func rePoint() {
        cP0.isHidden = true
        cP1.isHidden = true
        cP2.isHidden = true
        cp3.isHidden = true
        cP4.isHidden = true
        cP5.isHidden = true
        cP6.isHidden = true
        cP7.isHidden = true
    }
    
    func loadPointBath(){
        //rePoint()
        
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                if user[self.staSceneBath] == "bathscene" {
                    print("ค่าเริ่มต้น")
                    cP0.isHidden = false
                }
                else{
                    print("เข็คฉากอื่น")
                    for num1 in 1 ... 4
                    {
                        if user[self.staSceneBath] == nameSceneBath[num1]{
                            switch num1 {
                            case 1:
                                cP1.isHidden = false
                                print("\(num1)")
                            case 2:
                                cP2.isHidden = false
                                print("\(num1)")
                            case 3:
                                cp3.isHidden = false
                                print("\(num1)")
                            case 4:
                                cP4.isHidden = false
                                print("\(num1)")
                            default:
                                print("Error load check point Bath")
                            }
                        }
                    }
                    
                }
            }
        } catch {
            print("what error")
            print(error)
        }
        
        
        
    }
    
    func loadPointHome(){
        print("rePoint")
        //rePoint()
        print("show new point")
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                if user[self.staSceneHome] == "liviingSet" {
                    print("ค่าเริ่มต้น")
                    cP0.isHidden = false
                }
                else{
                    print("เข็คฉากอื่น")
                    for num1 in 1 ... 7
                    {
                        if user[self.staSceneHome] == nameSceneLiving[num1]{
                            switch num1 {
                            case 1:
                                cP1.isHidden = false
                                print("\(num1)")
                            case 2:
                                cP2.isHidden = false
                                print("\(num1)")
                            case 3:
                                cp3.isHidden = false
                                print("\(num1)")
                            case 4:
                                cP4.isHidden = false
                                print("\(num1)")
                            case 5:
                                cP5.isHidden = false
                                print("\(num1)")
                            case 6:
                                cP6.isHidden = false
                                print("\(num1)")
                            case 7:
                                cP7.isHidden = false
                                print("\(num1)")
                            default:
                                print("Error load check point Home")
                            }
                        }
                    }
                    
                }
            }
        } catch {
            print("what error")
            print(error)
        }
    }
    
    func loadData(){
        
        for num in 1...7 {
            do {
                let users = try self.database3.prepare(self.sceneTable)
                for user in users {
                    if user[self.sceneName] == nameSceneLiving[num] {
                        if user[self.sceneSta] == true {
                            switch num {
                            case 1:
                                btL1.setImage( UIImage(named: user[self.sceneName]), for: .normal)
                            case 2:
                                btL2.setImage( UIImage(named: user[self.sceneName]), for: .normal)
                            case 3:
                                btL3.setImage( UIImage(named: user[self.sceneName]), for: .normal)
                            case 4:
                                btL4.setImage( UIImage(named: user[self.sceneName]), for: .normal)
                            case 5:
                                btL5.setImage( UIImage(named: user[self.sceneName]), for: .normal)
                            case 6:
                                btL6.setImage( UIImage(named: user[self.sceneName]), for: .normal)
                            case 7:
                                btL7.setImage( UIImage(named: user[self.sceneName]), for: .normal)
                            default:
                                print("Error load livingroom")
                            }
                        }
                    }
                }
            } catch {
                print("what error")
                print(error)
            }
        }
        
        for num in 1...4 {
            do {
                let users = try self.database3.prepare(self.sceneTable)
                for user in users {
                    if user[self.sceneName] == nameSceneBath[num] {
                        if user[self.sceneSta] == true {
                            switch num {
                            case 1:
                                btB1.setImage( UIImage(named: user[self.sceneName]), for: .normal)
                            case 2:
                                btB2.setImage( UIImage(named: user[self.sceneName]), for: .normal)
                            case 3:
                                btB3.setImage( UIImage(named: user[self.sceneName]), for: .normal)
                            case 4:
                                btB4.setImage( UIImage(named: user[self.sceneName]), for: .normal)
                            default:
                                print("Error load bathroom")
                            }
                        }
                    }
                }
            } catch {
                print("what error")
                print(error)
            }
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
