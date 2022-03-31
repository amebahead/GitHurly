//
//  ViewController.swift
//  GitHurly
//
//  Created by MacDole on 2022/03/31.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var searchBarView: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set Title
        self.title = "Repositories"
        
        // Add SearchBarView in NavigationBar
        navigationItem.titleView = searchBarView
        
        // TableView
        tableView.delegate = self
        tableView.dataSource = self
        
        // SearchBar
        searchBarView.delegate = self
    }
}

// MARK: UITableViewDelegate
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 195.0
    }
}

extension ViewController: UITableViewDelegate {}

// MARK: UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    
}
