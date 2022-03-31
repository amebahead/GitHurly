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
    
    var results = [Item]()
    
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
        
        //
        APICaller.shared.search(query: "tetris", page: 1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                print(data)
                
                if data.items.count > 0 {
                    // Clear
                    self.results.removeAll()
                    
                    // Reload
                    self.results = data.items
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            case let .failure(err):
                print(err.localizedDescription)
            }
        }
    }
}

// MARK: UITableViewDelegate
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        
        let this = self.results[indexPath.row]
        cell.configure(this)
        
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
