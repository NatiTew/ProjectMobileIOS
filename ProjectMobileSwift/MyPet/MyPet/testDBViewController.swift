//
//  testDBViewController.swift
//  MyPet
//
//  Created by Tanawadee Supraphakorn on 4/8/18.
//  Copyright © 2018 Natthaphon. All rights reserved.
//

import UIKit
import SQLite

class testDBViewController: UIViewController {

    var database: Connection!
    
    let usersTable = Table("petTest11")
//    let id = Expression<Int>("id")
//    let name = Expression<String>("name")
//    let email = Expression<String>("email")
    
    let chooseType = Expression<Int>("chooseType")
    let namePet = Expression<String>("namePet")
    let coin = Expression<Int>("coin")
    let statusHeart = Expression<Int>("statusHeart")
    
    
    @IBAction func cre(_ sender: Any) {
        print("CREATE TAPPED")
        
        let createTable = self.usersTable.create { (table) in
            table.column(self.chooseType, primaryKey: true)
            table.column(self.namePet)
            table.column(self.coin)
            table.column(self.statusHeart)
        }
        
        do {
            try self.database.run(createTable)
            print("Created Table")
        } catch {
            print(error)
        }
    }
    
    @IBAction func inse(_ sender: Any) {
        var f = false
        
        print("INSERT TAPPED")
        let typep = 1
        let namep = "fa"
        let coinp = 100
        let sta = 100
            let insertUser = self.usersTable.insert(self.chooseType <- typep,self.namePet <- namep, self.coin <- coinp, self.statusHeart <- sta)
        
            do {
                try self.database.run(insertUser)
                print("INSERTED USER")
                f = true
            } catch {
                print(error)
            }
        if f == true{
        }
        else
        {
            print("not data")
        }
    }
    
    @IBAction func li(_ sender: Any) {
        print("LIST TAPPED")
        
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                print("typePet: \(user[self.chooseType]), name: \(user[self.namePet]), coin: \(user[self.coin]), status: \(user[self.statusHeart])")
                
                if user[self.namePet] == ""{
                    print("no name")
                }
            }
        } catch {
            print("what error")
            print(error)
        }
    }
    
    @IBAction func up(_ sender: Any) {
//        print("UPDATE TAPPED")
//        let alert = UIAlertController(title: "Update User", message: nil, preferredStyle: .alert)
//        alert.addTextField { (tf) in tf.placeholder = "User ID" }
//        alert.addTextField { (tf) in tf.placeholder = "Email" }
//        let action = UIAlertAction(title: "Submit", style: .default) { (_) in
//            guard let userIdString = alert.textFields?.first?.text,
//                let userId = Int(userIdString),
//                let email = alert.textFields?.last?.text
//                else { return }
//            print(userIdString)
//            print(email)
//
//            let user = self.usersTable.filter(self.id == userId)
//            let updateUser = user.update(self.email <- email)
//            do {
//                try self.database.run(updateUser)
//            } catch {
//                print(error)
//            }
//        }
//        alert.addAction(action)
//        present(alert, animated: true, completion: nil)
    }
    @IBAction func del(_ sender: Any) {
//        print("DELETE TAPPED")
//        let alert = UIAlertController(title: "Update User", message: nil, preferredStyle: .alert)
//        alert.addTextField { (tf) in tf.placeholder = "User ID" }
//        let action = UIAlertAction(title: "Submit", style: .default) { (_) in
//            guard let userIdString = alert.textFields?.first?.text,
//                let userId = Int(userIdString)
//                else { return }
//            print(userIdString)
//            
//            let user = self.usersTable.filter(self.id == userId)
//            let deleteUser = user.delete()
//            do {
//                try self.database.run(deleteUser)
//            } catch {
//                print(error)
//            }
//        }
//        alert.addAction(action)
//        present(alert, animated: true, completion: nil)
    }
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("petTest11").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch {
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
