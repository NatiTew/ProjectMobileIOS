//
//  RockPaperScissorViewController.swift
//  MyPet
//
//  Created by Tanawadee Supraphakorn on 3/8/18.
//  Copyright © 2018 Natthaphon. All rights reserved.
//

import UIKit
import SQLite


class RockPaperScissorViewController: UIViewController {
    var database: Connection!
    
    let usersTable = Table("petTest11")
    
    let chooseType = Expression<Int>("chooseType")
    let coin = Expression<Int>("coin")
    
    @IBOutlet weak var Stackchoose: UIStackView!
    @IBOutlet weak var L: UIImageView!
    @IBOutlet weak var R: UIImageView!
    @IBOutlet weak var petScore: UILabel!
    @IBOutlet weak var botScore: UILabel!
    
    
    var chooseR: Dictionary = [1 : "rockR", 2 : "paperR", 3 : "scissorsR"]
    var chooseL: Dictionary = [1 : "rock", 2 : "paper", 3 : "scissors"]
    
    var checkthree = 0
    
    @IBAction func rockRBtn(_ sender: Any) {
        if checkthree <= 2{
            L.image = UIImage(named : chooseR[1]!)
            L.isHidden = false
            ran(tmp: 1)
        }
    }
    
    @IBAction func paperRBtn(_ sender: Any) {
        if checkthree <= 2{
            L.image = UIImage(named : chooseR[2]!)
            L.isHidden = false
            ran(tmp: 2)
        }
    }
    
    @IBAction func scissorRBtn(_ sender: Any) {
        if checkthree <= 2{
            L.image = UIImage(named : chooseR[3]!)
            L.isHidden = false
            print("test1")
            ran(tmp: 3)
        }
    }
    
    func winer() {
        let scorePet: Int? = Int(petScore.text!)
        var num = 0
        if scorePet == 3{
            updateCoin(coinUp: 15)
            num = 15
        }else if scorePet == 2{
            updateCoin(coinUp: 10)
            num = 10
        }else if scorePet == 1{
            updateCoin(coinUp: 5)
            num = 5
        }
        let alert = UIAlertController(title: "ผลลัพธ์ คุณชนะ", message: "คุณชนะได้รับ \(num) เหรียญ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ย้อนกลับ", style: .default, handler: {action in self.performSegue(withIdentifier: "miniGameSe", sender: self) }))
        self.present(alert, animated: true)
    }
    func loser() {
        let scorePet: Int? = Int(petScore.text!)
        var num = 0
        if scorePet == 3{
            updateCoin(coinUp: 15)
            num = 15
        }else if scorePet == 2{
            updateCoin(coinUp: 10)
            num = 10
        }else if scorePet == 1{
            updateCoin(coinUp: 5)
            num = 5
        }
        
        let alert = UIAlertController(title: "ผลลัพธ์ คุณแพ้", message: "คุณชนะได้รับ \(num) เหรียญ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ย้อนกลับ", style: .default, handler: {action in self.performSegue(withIdentifier: "miniGameSe", sender: self) }))
        self.present(alert, animated: true)
    }
    
    func updateCoin(coinUp: Int){
        var coinDB: Int = -100
        var typeDB: Int = 0
        
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                typeDB = user[self.chooseType]
                coinDB = user[self.coin]
                
                    let payMoney = coinDB + coinUp
                
                    let id = self.usersTable.filter(self.chooseType == typeDB)
                    let updateMon = id.update(self.coin <- payMoney)
                    
                    do {
                        print("Updte Mon")
                        try self.database.run(updateMon)
                    } catch {
                        print(error)
                    }
            }
        } catch {
            print("what error priceFood")
            print(error)
        }
    }
    
    func checkToWin() {
        let scorePet: Int? = Int(petScore.text!)
        let scoreBot: Int? = Int(botScore.text!)
        if checkthree == 3{
            if scorePet! > scoreBot!{
                winer()
            }
            else{
                loser()
            }
        }
        
    }
    
    func ran(tmp: Int) {
        print("test2")
        let numRan = (Int(arc4random_uniform(30))%3)
        R.image = UIImage(named: chooseL[(numRan+1)]!)
        R.isHidden = false
   
        if tmp == 1 && numRan == 0 {
            checkToWin()
            
        } else if tmp == 1 && numRan == 1 {
            
            checkthree = checkthree + 1
            let test: Int? = Int(botScore.text!)
            botScore.text = String(test!+1)
            
            checkToWin()
            
        } else if tmp == 1 && numRan == 2 {
            
            checkthree = checkthree + 1
            let test: Int? = Int(petScore.text!)
            petScore.text = String(test!+1)
            
            checkToWin()
            
        } else if tmp == 2 && numRan == 0 {
            
            checkthree = checkthree + 1
            let test: Int? = Int(petScore.text!)
            petScore.text = String(test!+1)
            
            checkToWin()
            
        } else if tmp == 2 && numRan == 1 {
            
            checkToWin()
            
        } else if tmp == 2 && numRan == 2 {
            
            checkthree = checkthree + 1
            let test: Int? = Int(botScore.text!)
            botScore.text = String(test!+1)
            
            checkToWin()
            
        } else if tmp == 3 && numRan == 0 {
            
            checkthree = checkthree + 1
            let test: Int? = Int(botScore.text!)
            botScore.text = String(test!+1)
            
            checkToWin()
            
        } else if tmp == 3 && numRan == 1 {
            
            checkthree = checkthree + 1
            let test: Int? = Int(petScore.text!)
            petScore.text = String(test!+1)
            
            checkToWin()
            
        } else if tmp == 3 && numRan == 2 {
            
            checkToWin()
            
        }
    }
    
    override func viewDidLoad() {
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
        // Do any additional setup after loading the view.
        petScore.text = "0"
        botScore.text = "0"
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
