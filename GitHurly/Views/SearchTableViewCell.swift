//
//  SearchTableViewCell.swift
//  GitHurly
//
//  Created by MacDole on 2022/03/31.
//

import UIKit
import Kingfisher

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(_ data: Item) {
        self.authorNameLabel.text = data.owner.login
        self.repoNameLabel.text = data.name
        self.descriptionLabel.text = data.description
        self.starCountLabel.text = "\(data.stargazers_count)"
        self.languageLabel.text = data.language
        
        // Using Kingfisher
        let url = URL(string: data.owner.avatar_url)
        self.profileImageView.kf.setImage(with: url)
    }
}
