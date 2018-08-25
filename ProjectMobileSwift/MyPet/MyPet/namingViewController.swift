//
//  namingViewController.swift
//  MyPet
//
//  Created by Natthaphon on 19/7/61.
//  Copyright © พ.ศ. 2561 Natthaphon. All rights reserved.
//

import UIKit

class namingViewController: UIViewController {
    @IBOutlet weak var namingTextField: UITextField!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func backToChoose(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextpage = storyboard.instantiateViewController(withIdentifier: "Choose")
        
        self.present(nextpage,animated: true, completion: nil)
    }
    @IBAction func goToMain(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextpage = storyboard.instantiateViewController(withIdentifier: "MyPet")
        
        self.present(nextpage,animated: true, completion: nil)
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        

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
