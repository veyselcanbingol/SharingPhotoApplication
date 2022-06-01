//
//  FeedViewController.swift
//  SharingPhotoApplication
//
//  Created by Veysel Can Bingöl on 30.05.2022.
//

import UIKit
import Firebase

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var emailArray = [String]()
    var commentArray = [String]()
    var imageArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        firebaseGetData()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.emailText.text = emailArray[indexPath.row]
        cell.commentText.text = commentArray[indexPath.row]
        cell.postImageView.image = UIImage(named: "photo")
        return cell
    }
    
    func firebaseGetData(){
        let firestoreDatabase = Firestore.firestore()
        firestoreDatabase.collection("Post").addSnapshotListener { (Snapshot, Error) in
            if Error != nil {
                print("Error")
            } else {
                if Snapshot?.isEmpty != true && Snapshot != nil {
                    for document in Snapshot!.documents {
                        if let imageUrlD = document.get("imageUrl") as? String{
                            self.imageArray.append(imageUrlD)
                        }
                        if let commentD = document.get("comment") as? String{
                            self.commentArray.append(commentD)
                        }
                        if let emailD = document.get("email") as? String{
                            self.emailArray.append(emailD)
                        }
                            
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    


}
