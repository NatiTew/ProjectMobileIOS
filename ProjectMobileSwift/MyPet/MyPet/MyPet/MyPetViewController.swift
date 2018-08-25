//
//  MyPetViewController.swift
//  MyPet
//
//  Created by NatiTew Munpholsri on 26/7/61.
//  Copyright © พ.ศ. 2561 Natthaphon. All rights reserved.
//

import UIKit
import SpriteKit
import SQLite

class MyPetViewController: UIViewController {
    var database: Connection!
    
    let usersTable = Table("petTest11")

    let chooseType = Expression<Int>("chooseType")
    let namePet = Expression<String>("namePet")
    let coin = Expression<Int>("coin")
    let statusHeart = Expression<Int>("statusHeart")
    
    
    @IBOutlet weak var sceanPetView: SKView!
    var scene:PetScene?
    
//    @IBOutlet weak var ItemFoodPopup: UIImageView!

    @IBOutlet weak var stackMenu: UIStackView!
    @IBOutlet weak var stackFood: UIStackView!
    @IBOutlet weak var linkHome: UIStackView!
    @IBOutlet weak var loadName: UILabel!
    @IBOutlet weak var loadCoin: UILabel!
    @IBOutlet weak var loadHeart: UILabel!
    
    
    let foodname = [1:"foodMove1",
                    2:"foodMove2",
                    3:"foodMove3",
                    4:"foodMove4",
                    5:"smile"]
    
    //    @IBOutlet weak var stackPrice: UIStackView!
    
    @IBAction func food1(_ sender: UIButton) {
        
        let go: Int =  Int(loadHeart.text!)!
        if go > 10{
            priceFood(payUp: 25, heartUp: 25, stafoo: 1)
        }
        else{
            let alert = UIAlertController(title: "แจ้งเตือน", message: "สัตว์เลี้ยงของคุณอ่อนแอ่ กรุณาใช้ยาเพื่อฟื้นฟู", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ตกลง", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    @IBAction func food2(_ sender: UIButton) {
        
        
        let go: Int =  Int(loadHeart.text!)!
        if go > 10{
            priceFood(payUp: 15, heartUp: 15, stafoo: 2)
        }
        else{
            let alert = UIAlertController(title: "แจ้งเตือน", message: "สัตว์เลี้ยงของคุณอ่อนแอ่ กรุณาใช้ยาเพื่อฟื้นฟู", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ตกลง", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    @IBAction func food3(_ sender: UIButton) {
        
        
        let go: Int =  Int(loadHeart.text!)!
        if go > 10{
            priceFood(payUp: 15, heartUp: 15, stafoo: 3)
        }
        else{
            let alert = UIAlertController(title: "แจ้งเตือน", message: "สัตว์เลี้ยงของคุณอ่อนแอ่ กรุณาใช้ยาเพื่อฟื้นฟู", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ตกลง", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    @IBAction func food4(_ sender: Any) {
        
        
        let go: Int =  Int(loadHeart.text!)!
        if go > 10{
            priceFood(payUp: 10, heartUp: 10, stafoo: 4)
        }
        else{
            let alert = UIAlertController(title: "แจ้งเตือน", message: "สัตว์เลี้ยงของคุณอ่อนแอ่ กรุณาใช้ยาเพื่อฟื้นฟู", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ตกลง", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    @IBAction func food5(_ sender: Any) {
        
        let go: Int =  Int(loadHeart.text!)!
        if go <= 10{
            priceFood(payUp: 30, heartUp: 40, stafoo: 5)
        }
        else{
            let alert = UIAlertController(title: "แจ้งเตือน", message: "ใช้ได้เฉพาะตอนสัตว์เลี้ยงของคุณอ่อนแอ่", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ตกลง", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
    }
    
    func priceFood(payUp: Int, heartUp: Int, stafoo: Int) {
        var coinDB: Int = -100
        var typeDB: Int = 0
        var heartDB: Int = -100
        
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                typeDB = user[self.chooseType]
                coinDB = user[self.coin]
                heartDB = user[self.statusHeart]
                
                if user[self.coin] < payUp{
                    print("Type is \(typeDB)")
                    let alert = UIAlertController(title: "แจ้งเตือน", message: "ยอดเงินของคุณไม่เพียงพอ", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "ตกลง", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    
                }else if (heartDB + heartUp) > 100{
                    let alert = UIAlertController(title: "แจ้งเตือน", message: "หัวใจสัตว์เลี้ยงของคุณมีเพียงพอแล้ว", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "ตกลง", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
                else{
                    self.scene?.stafood = foodname[stafoo]!
                    let payMoney = coinDB - payUp
                    let payHeart = heartDB + heartUp

                    let id = self.usersTable.filter(self.chooseType == typeDB)
                    let updateMon = id.update(self.coin <- payMoney)
                    let updateHeart = id.update(self.statusHeart <- payHeart)
                    
                    do {
                        print("Updte Mon")
                        try self.database.run(updateMon)
                    } catch {
                        print(error)
                    }
                    
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
    
    
    
    @IBAction func goToFood(_ sender: Any) {

        stackMenu.isHidden = true
        stackFood.isHidden = false
        linkHome.isHidden = false
    }
    
    @IBAction func homeTOMYPet(_ sender: Any) {
        
        stackMenu.isHidden = false
        stackFood.isHidden = true
        linkHome.isHidden = true
    }
    
    
//    @IBAction func closeToMyPet(_ sender: Any) {
//        ItemFoodPopup.isHidden = true
//        stackClose.isHidden = true
//        stackMenu.isHidden = false
//        stackPrice.isHidden = true
//    }
    
    @IBAction func goToilet(_ sender: Any) {
        
        scene?.removeAllChildren()
        scene?.removeAllActions()
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let nextpage = storyboard.instantiateViewController(withIdentifier: "Toilet")
//        self.present(nextpage,animated: true, completion: nil)
    }
    @IBAction func goGame(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let nextpage = storyboard.instantiateViewController(withIdentifier: "MiniGame")
//
//        self.present(nextpage,animated: true, completion: nil)
    }
    @IBAction func goScene(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let nextpage = storyboard.instantiateViewController(withIdentifier: "ChooseScene")
//
//        self.present(nextpage,animated: true, completion: nil)
    }
    @IBAction func sound(_ sender: Any) {
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        loadName.backgroundColor = UIColor(patternImage: UIImage(named: "btnName")!)
        
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let  fileUrl = documentDirectory.appendingPathComponent("petTest11").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch  {
            print(error)
        }
        loadData()
        
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "livingroom2.png")!)
        
        self.scene = PetScene(size: CGSize(width: self.sceanPetView.frame.size.width, height: self.sceanPetView.frame.size.height))
        //self.scene?.you = "love"

        self.sceanPetView.presentScene(scene)
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
