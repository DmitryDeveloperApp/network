//
//  ViewController.swift
//  Networking
//
//  Created by Dmitry Suprun on 23.05.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func dowloadPostsDidTap() {
        
        networkManager.getAllPosts { [weak self] (posts) in
            DispatchQueue.main.async {
                self?.titleLabel.text = "Post has been downloader"
            }
        }
        
    }
}

