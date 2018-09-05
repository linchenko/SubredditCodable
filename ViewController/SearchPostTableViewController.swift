//
//  SearchPostTableViewController.swift
//  SubredditCodable
//
//  Created by Levi Linchenko on 04/09/2018.
//  Copyright © 2018 Levi Linchenko. All rights reserved.
//

import UIKit

class SearchPostTableViewController: UITableViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        PostController.shared.fetchPosts(by: "funny") { (posts) in
            guard let posts = posts else {return}
            DispatchQueue.main.async {
                self.posts = posts
                self.tableView.reloadData()
            }
        }

    }

    @IBOutlet weak var searchBar: UISearchBar!
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {return}
        guard searchText != "" else {return}
        PostController.shared.fetchPosts(by: searchText.lowercased()) { (posts) in
            guard let posts = posts else {return}
            DispatchQueue.main.async {
                self.posts = posts
                self.tableView.reloadData()
            }
        }
    }
    
    var posts: [Post]?

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return posts?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell,
                let posts = posts else {return UITableViewCell()}
        let post = posts[indexPath.row]
        PostController.shared.fetchImage(postThumbNail: post.thumbnailEndPoint) { (image) in
            DispatchQueue.main.async {
                cell.post = post
                if let currentIndexPath = self.tableView.indexPath(for: cell),
                    currentIndexPath == indexPath{
                    cell.postImage = image
                } else {
                    print("Got image for now-reused cell")
                    return
                }
                
            }
        }

        // Configure the cell...

        return cell ?? UITableViewCell()
    }

    

   


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
