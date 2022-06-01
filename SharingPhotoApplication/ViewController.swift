//
//  ViewController.swift
//  SharingPhotoApplication
//
//  Created by Veysel Can Bingöl on 30.05.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func clickedSignIn(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (AuthDataResult, Error) in
                if Error != nil {
                    self.errorMsg(titleInput: "Error", messageInput: Error?.localizedDescription ?? "Error, please try again!")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
            self.errorMsg(titleInput: "Error", messageInput: "Enter email and password!")
        }
    }
    @IBAction func clickedSignUp(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (AuthDataResult, Error) in
                if Error != nil {
                    self.errorMsg(titleInput: "Error", messageInput: Error?.localizedDescription ?? "Error, please try again!")
                } else  {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        } else {
            errorMsg(titleInput: "Error", messageInput: "Enter email and password!")
        }
    }
    func errorMsg(titleInput:String,messageInput:String){
        
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title:  "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
}

