//
//  PostTableViewCell.swift
//  Networking
//
//  Created by Dmitry Suprun on 24.05.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postBodyLable: UILabel!
    
    func configure(_ post: Post) {
        postTitleLabel.text = post.title
        postBodyLable.text = post.body
    }
    
}
