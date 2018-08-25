//
//  oxViewController.swift
//  MyPet
//
//  Created by Tanawadee Supraphakorn on 9/8/18.
//  Copyright © 2018 Natthaphon. All rights reserved.
//

import UIKit
import SQLite

class oxViewController: UIViewController {
    var database: Connection!
    
    let usersTable = Table("petTest11")
    
    let chooseType = Expression<Int>("chooseType")
    let coin = Expression<Int>("coin")

    var activePlayer = 1 //Cross
    var gameState = [0,0,0,
                     0,0,0,
                     0,0,0]
    let winningCombinations = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    @IBOutlet var But1: UIButton!
    @IBOutlet var But2: UIButton!
    @IBOutlet var But3: UIButton!
    @IBOutlet var But4: UIButton!
    @IBOutlet var But5: UIButton!
    @IBOutlet var But6: UIButton!
    @IBOutlet var But7: UIButton!
    @IBOutlet var But8: UIButton!
    @IBOutlet var But9: UIButton!
    var numInt = 0
    var test = 0
    var check = true
    
    var gameIsActive = true
    @IBOutlet weak var label: UILabel!
    func CheckWin()
    {
        Wincheck: for combination in winningCombinations
        {
            numInt += 1
            //print(gameState[0],gameState[1],gameState[2],gameState[3],gameState[4],gameState[5],gameState[6],gameState[7],gameState[8])
            if (gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]] )
            {
                gameIsActive = false
                print(gameIsActive)
                if (gameState[combination[0]] == 1 )
                {
                    //Cross has won
                    label.text = "You win!!"
                    
                    label.isHidden = false
                    check = false
                    print("win",gameIsActive)
                    updateCoin(coinUp: 10)
                    break Wincheck
                }
                else if(gameState[combination[0]] == 2)
                {
                    //Nought has won
                    label.text = "You lose!!"
                    
                    label.isHidden = false
                    check = false
                    
                    break Wincheck
                }
                
            }
            else if(numInt == 72)
            {
                gameIsActive = false
                label.text = "Draw!!"
                label.isHidden = false
                updateCoin(coinUp: 5)
                break
            }
        }
        if(activePlayer == 2 && gameIsActive == true) {
            print(gameIsActive)
            if(activePlayer == 2 && gameIsActive == true )
            {
                RandomBot()
            }
        }
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
    
    func RandomBot()
    {
        let testrandom = Int(arc4random_uniform(9))
        if(gameIsActive == true)
        {
            if(gameState[testrandom] == 0 && activePlayer == 2)
            {
                switch testrandom+1 {
                case But1.tag:
                    Action(But1)
                case But2.tag:
                    Action(But2)
                case But3.tag:
                    Action(But3)
                case But4.tag:
                    Action(But4)
                case But5.tag:
                    Action(But5)
                case But6.tag:
                    Action(But6)
                case But7.tag:
                    Action(But7)
                case But8.tag:
                    Action(But8)
                case But9.tag:
                    Action(But9)
                default:
                    break
                }
            }
            else
            {
                RandomBot()
            }
        }
    }
    @IBAction func Action(_ sender: AnyObject)
    {
        //print(check)
        if (gameState[sender.tag-1] == 0 && gameIsActive == true )
        {
            gameState[sender.tag-1] = activePlayer
            
            if (activePlayer == 1 && check)
            {
                
                sender.setImage(UIImage(named: "Cross2.png"), for: UIControlState())
                activePlayer = 2
                test = test+1
                CheckWin()
                //print(check)
            }
            else if(activePlayer == 2 && check)
            {
                //print("bot",check)
                
                sender.setImage(UIImage(named: "Nought2.jpg"), for: UIControlState())
                activePlayer = 1
                CheckWin()
                //print("bot")
                
                
                
            }
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
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
