//
//  PostTableViewCell.swift
//  SubredditCodable
//
//  Created by Levi Linchenko on 04/09/2018.
//  Copyright © 2018 Levi Linchenko. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var titleOutlet: UILabel!
    @IBOutlet weak var votesOutlet: UILabel!
    @IBOutlet weak var commentsOutlet: UILabel!
    @IBOutlet weak var thumbnailOutlet: UIImageView!
    
    var post: Post?{
        didSet{
            updateViews()
        }
    }
    var postImage: UIImage?{
        didSet{
            updateViews()

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateViews(){
        guard let post = post else {return}
        titleOutlet.text = post.title
        votesOutlet.text = "\(post.numberOfUpvotes)"
        commentsOutlet.text = "\(post.numberOfComments)"
        if let postImage = postImage{
            thumbnailOutlet.image = postImage
        }

        
        
    }

}
