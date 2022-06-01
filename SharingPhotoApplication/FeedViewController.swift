//
//  FeedViewController.swift
//  SharingPhotoApplication
//
//  Created by Veysel Can Bingöl on 30.05.2022.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.emailText.text = "vyslcnbngl@gmail.com"
        cell.commentText.text = "That's very nice!"
        cell.postImageView.image = UIImage(named: "Upload.svg")
        return cell
    }
    


}
