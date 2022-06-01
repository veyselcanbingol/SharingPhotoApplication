//
//  SettingsViewController.swift
//  SharingPhotoApplication
//
//  Created by Veysel Can Bingöl on 30.05.2022.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
 
    @IBAction func clickedExit(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toViewController", sender: nil)
        } catch {
            
        }
        
      
    }
}
