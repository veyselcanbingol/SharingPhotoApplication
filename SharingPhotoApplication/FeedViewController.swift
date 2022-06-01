//
//  FeedViewController.swift
//  SharingPhotoApplication
//
//  Created by Veysel Can Bingöl on 30.05.2022.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    /* var emailArray = [String]()
     var commentArray = [String]()
     var imageArray = [String]()
     */
    var postArray = [Post]( )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        firebaseGetData()
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.emailText.text = postArray[indexPath.row].email
        cell.commentText.text = postArray[indexPath.row].comment
        cell.postImageView.sd_setImage(with: URL(string: self.postArray[indexPath.row].imageUrl))
        return cell
    }
    
    func firebaseGetData(){
        let firestoreDatabase = Firestore.firestore()
        firestoreDatabase.collection("Post")
            .order(by: "date", descending: true)
            .addSnapshotListener { (Snapshot, Error) in
                if Error != nil {
                    print("Error")
                } else {
                    
                    self.postArray.removeAll(keepingCapacity: false)
                    
                    if Snapshot?.isEmpty != true && Snapshot != nil {
                        for document in Snapshot!.documents {
                            if let imageUrlD = document.get("imageUrl") as? String{
                                if let commentD = document.get("comment") as? String{
                                    if let emailD = document.get("email") as? String{
                                        let post = Post(email: emailD, comment: commentD, imageUrl: imageUrlD)
                                        self.postArray.append(post)
                                    }
                                }
                            }
                        }
                        self.tableView.reloadData()
                    }
                }
            }
    }
    
    
    
}
