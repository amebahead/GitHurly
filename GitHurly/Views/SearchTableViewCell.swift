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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.authorNameLabel.text = nil
        self.repoNameLabel.text = nil
        self.descriptionLabel.text = nil
        self.starCountLabel.text = nil
        self.languageLabel.text = nil
        self.profileImageView.image = nil
    }
    
    public func configure(_ data: Item) {
        self.authorNameLabel.text = data.owner.login
        self.repoNameLabel.text = data.name
        self.descriptionLabel.text = data.description
        self.starCountLabel.text = data.formattedStarCount
        self.languageLabel.text = data.language
        
        // Using Kingfisher
        if let url = data.owner.avatar_url {
            let thisUrl = URL(string: url)
            self.profileImageView.kf.setImage(with: thisUrl)
        }
    }
}
