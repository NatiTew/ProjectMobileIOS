//
//  MiniGameViewController.swift
//  MyPet
//
//  Created by NatiTew Munpholsri on 30/7/61.
//  Copyright © พ.ศ. 2561 Natthaphon. All rights reserved.
//

import UIKit
import SQLite

class MiniGameViewController: UIViewController {
    var database: Connection!
    
    let usersTable = Table("petTest11")
    
    let chooseType = Expression<Int>("chooseType")
    let statusHeart = Expression<Int>("statusHeart")
    
    
    @IBAction func btOx(_ sender: Any) {
        var typeDB: Int = 0
        var heartDB: Int = -100
        
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                typeDB = user[self.chooseType]
                heartDB = user[self.statusHeart]
                
                if  heartDB < 5{
                    let alert = UIAlertController(title: "แจ้งเตือน", message: "หัวใจสัตว์เลี้ยงของคุณมีไม่เพียงพอ", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "ตกลง", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
                else{
                    let payHeart = heartDB - 10
                    let id = self.usersTable.filter(self.chooseType == typeDB)
                    let updateHeart = id.update(self.statusHeart <- payHeart)
                    
                    do {
                        print("Update Heart")
                        try self.database.run(updateHeart)
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let nextpage = storyboard.instantiateViewController(withIdentifier: "g3")
                        
                        self.present(nextpage,animated: true, completion: nil)
                    } catch {
                        print(error)
                    }
                }
            }
        } catch {
            print("what error priceFood")
            print(error)
        }
        
    }
    @IBAction func btSpace(_ sender: Any) {
        var typeDB: Int = 0
        var heartDB: Int = -100
        
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                typeDB = user[self.chooseType]
                heartDB = user[self.statusHeart]
                
                if  heartDB < 5{
                    let alert = UIAlertController(title: "แจ้งเตือน", message: "หัวใจสัตว์เลี้ยงของคุณมีไม่เพียงพอ", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "ตกลง", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
                else{
                    let payHeart = heartDB - 10
                    let id = self.usersTable.filter(self.chooseType == typeDB)
                    let updateHeart = id.update(self.statusHeart <- payHeart)
                    
                    do {
                        print("Update Heart")
                        try self.database.run(updateHeart)
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let nextpage = storyboard.instantiateViewController(withIdentifier: "g2")
                        
                        self.present(nextpage,animated: true, completion: nil)
                    } catch {
                        print(error)
                    }
                }
            }
        } catch {
            print("what error priceFood")
            print(error)
        }
    }
    @IBAction func btWinToWin(_ sender: Any) {
        var typeDB: Int = 0
        var heartDB: Int = -100
        
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                typeDB = user[self.chooseType]
                heartDB = user[self.statusHeart]
                
                if  heartDB < 5{
                    let alert = UIAlertController(title: "แจ้งเตือน", message: "หัวใจสัตว์เลี้ยงของคุณมีไม่เพียงพอ", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "ตกลง", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
                else{
                    let payHeart = heartDB - 10
                    let id = self.usersTable.filter(self.chooseType == typeDB)
                    let updateHeart = id.update(self.statusHeart <- payHeart)
                    
                    do {
                        print("Update Heart")
                        try self.database.run(updateHeart)
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let nextpage = storyboard.instantiateViewController(withIdentifier: "g1")
                        
                        self.present(nextpage,animated: true, completion: nil)
                    } catch {
                        print(error)
                    }
                }
            }
        } catch {
            print("what error priceFood")
            print(error)
        }
    }
    @IBAction func btChoosePic(_ sender: Any) {
        var typeDB: Int = 0
        var heartDB: Int = -100
        
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                typeDB = user[self.chooseType]
                heartDB = user[self.statusHeart]
                
                if  heartDB < 5{
                    let alert = UIAlertController(title: "แจ้งเตือน", message: "หัวใจสัตว์เลี้ยงของคุณมีไม่เพียงพอ", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "ตกลง", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
                else{
                    let payHeart = heartDB - 10
                    let id = self.usersTable.filter(self.chooseType == typeDB)
                    let updateHeart = id.update(self.statusHeart <- payHeart)
                    
                    do {
                        print("Update Heart")
                        try self.database.run(updateHeart)
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let nextpage = storyboard.instantiateViewController(withIdentifier: "g4")
                        
                        self.present(nextpage,animated: true, completion: nil)
                    } catch {
                        print(error)
                    }
                }
            }
        } catch {
            print("what error priceFood")
            print(error)
        }
    }

    

    override func viewDidLoad() {
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
        super.viewDidLoad()
        

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
