//
//  UploadViewController.swift
//  SharingPhotoApplication
//
//  Created by Veysel Can Bingöl on 30.05.2022.
//

import UIKit
import FirebaseStorage
import Firebase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosePhoto))
        imageView.addGestureRecognizer(gestureRecognizer)
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func choosePhoto(){
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true , completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    @IBAction func clickedUpload(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            
            let uuid = UUID().uuidString
            
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data) { StorageMetadata, Error in
                if Error != nil {
                    self.errorMsg(errorTitle: "Error", errorMessage: Error?.localizedDescription ?? "Error, please try again!")
                } else {
                    imageReference.downloadURL { URL, Error in
                        if Error == nil {
                            let imageUrl = URL?.absoluteString
                            if let imageUrl = imageUrl {
                                let firestoreDatabase = Firestore.firestore()
                                let firestorePost = ["imageUrl" : imageUrl, "comment": self.commentTextField.text, "email": Auth.auth().currentUser!.email, "date":FieldValue.serverTimestamp()] as [String : Any]
                                firestoreDatabase.collection("Post").addDocument(data: firestorePost) { Error in
                                    if Error != nil {
                                        self.errorMsg(errorTitle: "Error", errorMessage: Error?.localizedDescription ?? "Error, please try again!")
                                    } else {
                                        self.imageView.image = UIImage(named: "Upload.svg")
                                        self.commentTextField.text = ""
                                        self.tabBarController?.selectedIndex = 0
                                        
                                    }
                                }
                                
                            }
                            
                            
                        }
                    }
                }
            }
        }
    }
    
    func errorMsg(errorTitle: String, errorMessage: String ){
        let alert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil )
        
    }
    
}
