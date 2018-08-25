//
//  findGameViewController.swift
//  MyPet
//
//  Created by Tanawadee Supraphakorn on 9/8/18.
//  Copyright © 2018 Natthaphon. All rights reserved.
//

import UIKit
import SQLite

class findGameViewController: UIViewController {
    var database: Connection!
    
    let usersTable = Table("petTest11")
    
    let chooseType = Expression<Int>("chooseType")
    let DBcoin = Expression<Int>("coin")

    @IBOutlet weak var btnA1: UIButton!
    
    @IBOutlet weak var btnA2: UIButton!
    @IBOutlet weak var btnA3: UIButton!
    @IBOutlet weak var btnB1: UIButton!
    @IBOutlet weak var btnB2: UIButton!
    @IBOutlet weak var btnB3: UIButton!
    @IBOutlet weak var btnB4: UIButton!
    @IBOutlet weak var btnA5: UIButton!
    @IBOutlet weak var btnA4: UIButton!
    @IBOutlet weak var btnA6: UIButton!
    @IBOutlet weak var btnB5: UIButton!
    @IBOutlet weak var btnB6: UIButton!
    @IBOutlet weak var btnC6: UIButton!
    @IBOutlet weak var btnC1: UIButton!
    @IBOutlet weak var btnC5: UIButton!
    @IBOutlet weak var btnC4: UIButton!
    @IBOutlet weak var btnC3: UIButton!
    @IBOutlet weak var btnC2: UIButton!
    @IBOutlet weak var btnD2: UIButton!
    @IBOutlet weak var btnD1: UIButton!
    @IBOutlet weak var btnD6: UIButton!
    @IBOutlet weak var btnD5: UIButton!
    @IBOutlet weak var btnD3: UIButton!
    @IBOutlet weak var btnD4: UIButton!
    @IBOutlet weak var btnE2: UIButton!
    @IBOutlet weak var btnE6: UIButton!
    @IBOutlet weak var btnE5: UIButton!
    @IBOutlet weak var btnE4: UIButton!
    @IBOutlet weak var btnE3: UIButton!
    @IBOutlet weak var btnE1: UIButton!
    @IBOutlet weak var imgA4: UIImageView!
    @IBOutlet weak var imgA5: UIImageView!
    @IBOutlet weak var imgA6: UIImageView!
    @IBOutlet weak var imgB4: UIImageView!
    @IBOutlet weak var imgB5: UIImageView!
    @IBOutlet weak var imgC2: UIImageView!
    @IBOutlet weak var imgC3: UIImageView!
    @IBOutlet weak var imgC4: UIImageView!
    @IBOutlet weak var imgC5: UIImageView!
    @IBOutlet weak var imgD2: UIImageView!
    @IBOutlet weak var imgD4: UIImageView!
    
    @IBOutlet weak var picL: UIImageView!
    @IBOutlet weak var picR: UIImageView!
    @IBOutlet weak var numOfLife: UILabel!
    
    func updateCoin(coinUp: Int){
        var coinDB: Int = -100
        var typeDB: Int = 0
        
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                typeDB = user[self.chooseType]
                coinDB = user[self.DBcoin]
                
                let payMoney = coinDB + coinUp
                
                let id = self.usersTable.filter(self.chooseType == typeDB)
                let updateMon = id.update(self.DBcoin <- payMoney)
                
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
    
    var numran = 0
    var numcount = 5
    var score = 0
    var coin = 0
    
    var imgL: Dictionary = [0 : "pics1", 1 : "pics2", 2 : "pics3"]
    var imgR: Dictionary = [0 : "pic1", 1 : "pic2", 2 : "pic3"]
    
    func ranImg() -> Int{
        numran = Int(arc4random_uniform(3))
        picL.image = UIImage(named: imgL[(numran)]!)
        picR.image = UIImage(named: imgR[(numran)]!)
        return numran
    }
    
    func alertLost() {
        if numcount <= 0 && score == 1{
            coin = 2
            let alert = UIAlertController(title: "คุณแพ้แล้ว", message: "ได้รับ 2 เหรียญ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { action in self.performSegue(withIdentifier: "miniGameSe", sender: self)
            }))
            self.present(alert, animated: true, completion: nil)
            
            updateCoin(coinUp: 2)
            
            btnA1.isEnabled = false
            btnA2.isEnabled = false
            btnA3.isEnabled = false
            btnA4.isEnabled = false
            btnA5.isEnabled = false
            btnA6.isEnabled = false
            
            btnB1.isEnabled = false
            btnB2.isEnabled = false
            btnB3.isEnabled = false
            btnB4.isEnabled = false
            btnB5.isEnabled = false
            btnB6.isEnabled = false
            
            btnC1.isEnabled = false
            btnC2.isEnabled = false
            btnC3.isEnabled = false
            btnC4.isEnabled = false
            btnC5.isEnabled = false
            btnC6.isEnabled = false
            
            btnD1.isEnabled = false
            btnD2.isEnabled = false
            btnD3.isEnabled = false
            btnD4.isEnabled = false
            btnD5.isEnabled = false
            btnD6.isEnabled = false
            
            btnE1.isEnabled = false
            btnE2.isEnabled = false
            btnE3.isEnabled = false
            btnE4.isEnabled = false
            btnE5.isEnabled = false
            btnE6.isEnabled = false
        }
        else if numcount <= 0 && score == 2{
            coin = 4
            let alert = UIAlertController(title: "คุณแพ้แล้ว", message: "ได้รับ 4 เหรียญ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: {action in self.performSegue(withIdentifier: "miniGameSe", sender: self) }))
            self.present(alert, animated: true, completion: nil)
            
            updateCoin(coinUp: 4)
            btnA1.isEnabled = false
            btnA2.isEnabled = false
            btnA3.isEnabled = false
            btnA4.isEnabled = false
            btnA5.isEnabled = false
            btnA6.isEnabled = false
            
            btnB1.isEnabled = false
            btnB2.isEnabled = false
            btnB3.isEnabled = false
            btnB4.isEnabled = false
            btnB5.isEnabled = false
            btnB6.isEnabled = false
            
            btnC1.isEnabled = false
            btnC2.isEnabled = false
            btnC3.isEnabled = false
            btnC4.isEnabled = false
            btnC5.isEnabled = false
            btnC6.isEnabled = false
            
            btnD1.isEnabled = false
            btnD2.isEnabled = false
            btnD3.isEnabled = false
            btnD4.isEnabled = false
            btnD5.isEnabled = false
            btnD6.isEnabled = false
            
            btnE1.isEnabled = false
            btnE2.isEnabled = false
            btnE3.isEnabled = false
            btnE4.isEnabled = false
            btnE5.isEnabled = false
            btnE6.isEnabled = false
            
        }
            
        else if numcount <= 0 && score == 3{
            coin = 6
            let alert = UIAlertController(title: "คุณแพ้แล้ว", message: "ได้รับ 6 เหรียญ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: {action in self.performSegue(withIdentifier: "miniGameSe", sender: self) }))
            self.present(alert, animated: true, completion: nil)
            
            updateCoin(coinUp: 6)
            btnA1.isEnabled = false
            btnA2.isEnabled = false
            btnA3.isEnabled = false
            btnA4.isEnabled = false
            btnA5.isEnabled = false
            btnA6.isEnabled = false
            
            btnB1.isEnabled = false
            btnB2.isEnabled = false
            btnB3.isEnabled = false
            btnB4.isEnabled = false
            btnB5.isEnabled = false
            btnB6.isEnabled = false
            
            btnC1.isEnabled = false
            btnC2.isEnabled = false
            btnC3.isEnabled = false
            btnC4.isEnabled = false
            btnC5.isEnabled = false
            btnC6.isEnabled = false
            
            btnD1.isEnabled = false
            btnD2.isEnabled = false
            btnD3.isEnabled = false
            btnD4.isEnabled = false
            btnD5.isEnabled = false
            btnD6.isEnabled = false
            
            btnE1.isEnabled = false
            btnE2.isEnabled = false
            btnE3.isEnabled = false
            btnE4.isEnabled = false
            btnE5.isEnabled = false
            btnE6.isEnabled = false
        }
            
        else if numcount <= 0 && score == 4{
            coin = 8
            let alert = UIAlertController(title: "คุณแพ้แล้ว", message: "ได้รับ 8 เหรียญ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: {action in self.performSegue(withIdentifier: "miniGameSe", sender: self) }))
            self.present(alert, animated: true, completion: nil)
            
            updateCoin(coinUp: 8)
            btnA1.isEnabled = false
            btnA2.isEnabled = false
            btnA3.isEnabled = false
            btnA4.isEnabled = false
            btnA5.isEnabled = false
            btnA6.isEnabled = false
            
            btnB1.isEnabled = false
            btnB2.isEnabled = false
            btnB3.isEnabled = false
            btnB4.isEnabled = false
            btnB5.isEnabled = false
            btnB6.isEnabled = false
            
            btnC1.isEnabled = false
            btnC2.isEnabled = false
            btnC3.isEnabled = false
            btnC4.isEnabled = false
            btnC5.isEnabled = false
            btnC6.isEnabled = false
            
            btnD1.isEnabled = false
            btnD2.isEnabled = false
            btnD3.isEnabled = false
            btnD4.isEnabled = false
            btnD5.isEnabled = false
            btnD6.isEnabled = false
            
            btnE1.isEnabled = false
            btnE2.isEnabled = false
            btnE3.isEnabled = false
            btnE4.isEnabled = false
            btnE5.isEnabled = false
            btnE6.isEnabled = false
        }
        else if(score == 5){
            coin = 10
            let alert = UIAlertController(title: "คุณชนะแล้ว", message: "ได้รับ 10 เหรียญ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: {action in self.performSegue(withIdentifier: "miniGameSe", sender: self) }))
            self.present(alert, animated: true, completion: nil)
            
            updateCoin(coinUp: 10)
            btnA1.isEnabled = false
            btnA2.isEnabled = false
            btnA3.isEnabled = false
            btnA4.isEnabled = false
            btnA5.isEnabled = false
            btnA6.isEnabled = false
            
            btnB1.isEnabled = false
            btnB2.isEnabled = false
            btnB3.isEnabled = false
            btnB4.isEnabled = false
            btnB5.isEnabled = false
            btnB6.isEnabled = false
            
            btnC1.isEnabled = false
            btnC2.isEnabled = false
            btnC3.isEnabled = false
            btnC4.isEnabled = false
            btnC5.isEnabled = false
            btnC6.isEnabled = false
            
            btnD1.isEnabled = false
            btnD2.isEnabled = false
            btnD3.isEnabled = false
            btnD4.isEnabled = false
            btnD5.isEnabled = false
            btnD6.isEnabled = false
            
            btnE1.isEnabled = false
            btnE2.isEnabled = false
            btnE3.isEnabled = false
            btnE4.isEnabled = false
            btnE5.isEnabled = false
            btnE6.isEnabled = false
        }
            
        else if numcount <= 0 {
            coin = 0
            let alert = UIAlertController(title: "คุณแพ้แล้ว", message: "ได้รับ 0 เหรียญ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: {action in self.performSegue(withIdentifier: "miniGameSe", sender: self) }))
            self.present(alert, animated: true, completion: nil)
            
            btnA1.isEnabled = false
            btnA2.isEnabled = false
            btnA3.isEnabled = false
            btnA4.isEnabled = false
            btnA5.isEnabled = false
            btnA6.isEnabled = false
            
            btnB1.isEnabled = false
            btnB2.isEnabled = false
            btnB3.isEnabled = false
            btnB4.isEnabled = false
            btnB5.isEnabled = false
            btnB6.isEnabled = false
            
            btnC1.isEnabled = false
            btnC2.isEnabled = false
            btnC3.isEnabled = false
            btnC4.isEnabled = false
            btnC5.isEnabled = false
            btnC6.isEnabled = false
            
            btnD1.isEnabled = false
            btnD2.isEnabled = false
            btnD3.isEnabled = false
            btnD4.isEnabled = false
            btnD5.isEnabled = false
            btnD6.isEnabled = false
            
            btnE1.isEnabled = false
            btnE2.isEnabled = false
            btnE3.isEnabled = false
            btnE4.isEnabled = false
            btnE5.isEnabled = false
            btnE6.isEnabled = false
        }
            
        else {}
        
    }
    
    @IBAction func btnA4(_ sender: Any) {
        
        if numran == 1 {
            imgA4.image = UIImage(named: "circle")
            score += 1
            alertLost()
            btnA4.isEnabled = false
        }
        else{}
    }
    
    
    
    @IBAction func btnA5(_ sender: Any) {
        if numran == 0 || numran == 1{
            imgA5.image = UIImage(named: "circle")
            score += 1
            alertLost()
            btnA5.isEnabled = false
        }
        else{}
    }
    
    @IBAction func btnA6(_ sender: Any) {
        if numran == 0 {
            imgA6.image = UIImage(named: "circle")
            score += 1
            alertLost()
            btnA6.isEnabled = false
        }
        else{}
    }
    
    @IBAction func btnB4(_ sender: Any) {
        if numran == 1 || numran == 2{
            imgB4.image = UIImage(named: "circle")
            score += 1
            alertLost()
            btnB4.isEnabled = false
        }
        else{}
    }
    
    @IBAction func btnB5(_ sender: Any) {
        if numran == 2 {
            imgB5.image = UIImage(named: "circle")
            score += 1
            alertLost()
            btnB5.isEnabled = false
        }
        else{}
        
    }
    
    @IBAction func btnC2(_ sender: Any) {
        if numran == 1 {
            imgC2.image = UIImage(named: "circle")
            score += 1
            alertLost()
            btnC2.isEnabled = false
        }
        else{}
    }
    
    @IBAction func btnC3(_ sender: Any) {
        if numran == 0 {
            imgC3.image = UIImage(named: "circle")
            score += 1
            alertLost()
            btnC3.isEnabled = false
        }
        else{}
    }
    
    
    @IBAction func btnC4(_ sender: Any) {
        if numran == 0 {
            imgC4.image = UIImage(named: "circle")
            score += 1
            alertLost()
            btnC4.isEnabled = false
        }
        else{}
    }
    
    
    @IBAction func btnC5(_ sender: Any) {
        if numran == 0 || numran == 1 || numran == 2 {
            imgC5.image = UIImage(named: "circle")
            score += 1
            alertLost()
            btnC5.isEnabled = false
        }
        else{}
    }
    
    
    @IBAction func btnD2(_ sender: Any) {
        if numran == 2 {
            imgD2.image = UIImage(named: "circle")
            score += 1
            alertLost()
            btnD2.isEnabled = false
        }
        else{}
    }
    
    @IBAction func btnD4(_ sender: Any) {
        if numran == 2 {
            imgD4.image = UIImage(named: "circle")
            score += 1
            alertLost()
            btnD4.isEnabled = false
        }
        else{}
    }
    
    
    @IBAction func btnA1(_ sender: Any) {
        numcount = numcount-1
        let myString = String(describing: numcount)
        self.numOfLife.text = myString
        alertLost()
    }
    
    @IBAction func btnA2(_ sender: Any) {
        numcount = numcount-1
        let myString = String(describing: numcount)
        self.numOfLife.text = myString
        alertLost()
    }
    
    
    @IBAction func btnA3(_ sender: Any) {
        numcount = numcount-1
        let myString = String(describing: numcount)
        self.numOfLife.text = myString
        alertLost()
    }
    
    
    @IBAction func btnB1(_ sender: Any) {
        numcount = numcount-1
        let myString = String(describing: numcount)
        self.numOfLife.text = myString
        alertLost()
    }
    
    @IBAction func btnB2(_ sender: Any) {
        numcount = numcount-1
        let myString = String(describing: numcount)
        self.numOfLife.text = myString
        alertLost()
    }
    
    @IBAction func btnB3(_ sender: Any) {
        numcount = numcount-1
        let myString = String(describing: numcount)
        self.numOfLife.text = myString
        alertLost()
    }
    
    @IBAction func btnB6(_ sender: Any) {
        numcount = numcount-1
        let myString = String(describing: numcount)
        self.numOfLife.text = myString
        alertLost()
    }
    
    
    @IBAction func btnC1(_ sender: Any) {
        numcount = numcount-1
        let myString = String(describing: numcount)
        self.numOfLife.text = myString
        alertLost()
    }
    @IBAction func btnC6(_ sender: Any) {
        numcount = numcount-1
        let myString = String(describing: numcount)
        self.numOfLife.text = myString
        alertLost()
    }
    
    @IBAction func btnD1(_ sender: Any) {
        numcount = numcount-1
        let myString = String(describing: numcount)
        self.numOfLife.text = myString
        alertLost()
    }
    
    @IBAction func btnD3(_ sender: Any) {
        numcount = numcount-1
        let myString = String(describing: numcount)
        self.numOfLife.text = myString
        alertLost()
    }
    @IBAction func btnD5(_ sender: Any) {
        numcount = numcount-1
        let myString = String(describing: numcount)
        self.numOfLife.text = myString
        alertLost()
    }
    @IBAction func btnD6(_ sender: Any) {
        numcount = numcount-1
        let myString = String(describing: numcount)
        self.numOfLife.text = myString
        alertLost()
    }
    
    @IBAction func btnE1(_ sender: Any) {
        numcount = numcount-1
        let myString = String(describing: numcount)
        self.numOfLife.text = myString
        alertLost()
    }
    
    @IBAction func btnE2(_ sender: Any) {
        numcount = numcount-1
        let myString = String(describing: numcount)
        self.numOfLife.text = myString
        alertLost()
    }
    
    @IBAction func btnE3(_ sender: Any) {
        numcount = numcount-1
        let myString = String(describing: numcount)
        self.numOfLife.text = myString
        alertLost()
    }
    
    @IBAction func btnE4(_ sender: Any) {
        numcount = numcount-1
        let myString = String(describing: numcount)
        self.numOfLife.text = myString
        alertLost()
    }
    
    @IBAction func btnE5(_ sender: Any) {
        numcount = numcount-1
        let myString = String(describing: numcount)
        self.numOfLife.text = myString
        alertLost()
    }
    @IBAction func btnE6(_ sender: Any) {
        numcount = numcount-1
        let myString = String(describing: numcount)
        self.numOfLife.text = myString
        alertLost()
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
        _ = ranImg()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
