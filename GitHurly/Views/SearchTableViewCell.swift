//
//  SearchTableViewCell.swift
//  GitHurly
//
//  Created by MacDole on 2022/03/31.
//

import UIKit

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
}
