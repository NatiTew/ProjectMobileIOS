//
//  BathroomViewController.swift
//  MyPet
//
//  Created by NatiTew Munpholsri on 31/7/61.
//  Copyright © พ.ศ. 2561 Natthaphon. All rights reserved.
//

import UIKit
import SpriteKit
import SQLite

class BathroomViewController: UIViewController {
    var database: Connection!
    
    let usersTable = Table("petTest11")
    
    let chooseType = Expression<Int>("chooseType")
    let namePet = Expression<String>("namePet")
    let coin = Expression<Int>("coin")
    let statusHeart = Expression<Int>("statusHeart")
    
    @IBOutlet weak var bathView: SKView!
    var scene:BathScene?
    
    @IBOutlet weak var loadCoin: UILabel!
    @IBOutlet weak var loadHeart: UILabel!
    @IBOutlet weak var loadName: UILabel!
    
    let bathname = [1:"bathMove1",
                    2:"bathMove2",
                    3:"bathMove3",
                    4:"bathMove4"]
    
    @IBAction func use1(_ sender: Any) {
        usedItem(num: 3, stafoo: 1)
    }
    @IBAction func use2(_ sender: Any) {
        usedItem(num: 2, stafoo: 2)
    }
    @IBAction func use3(_ sender: Any) {
        usedItem(num: 3, stafoo: 3)
    }
    @IBAction func use4(_ sender: Any) {
        usedItem(num: 2, stafoo: 4)
    }
    
    func usedItem(num: Int, stafoo: Int) {
        var heartDB: Int = -100
        var typeDB: Int = 0
        
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                typeDB = user[self.chooseType]
                heartDB = user[self.statusHeart]
                
                if (heartDB + num) > 100{
                    let alert = UIAlertController(title: "แจ้งเตือน", message: "หัวใจสัตว์เลี้ยงของคุณมีเพียงพอแล้ว", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "ตกลง", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
                else{
                    self.scene?.stafood = bathname[stafoo]!
                    let payHeart = heartDB + num
                    
                    let id = self.usersTable.filter(self.chooseType == typeDB)
                    let updateHeart = id.update(self.statusHeart <- payHeart)
                    do {
                        print("Update Heart")
                        try self.database.run(updateHeart)
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
        

        loadData()
        
        self.scene = BathScene(size: CGSize(width: self.bathView.frame.size.width, height: self.bathView.frame.size.height))
        self.bathView.presentScene(scene)
        
        loadName.backgroundColor = UIColor(patternImage: UIImage(named: "btnName")!)

        // Do any additional setup after loading the view.
    }
    
    func loadData() {
        
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                loadName.text = user[self.namePet]
                loadCoin.text = String(user[self.coin])
                loadHeart.text = String(user[self.statusHeart])
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
