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
    
    // Search Factor
    var currentQuery = "tetris"
    var currentPage = 1
    
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
        self.fetchData(query: self.currentQuery, page: self.currentPage)
    }
}

// MARK: Function
extension ViewController {
    private func fetchData(query: String, page: Int, isClear: Bool = false) {
        if query.isEmpty { return }
        
        APICaller.shared.search(query: query, page: page) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                print(data)
                
                if data.items.count > 0 {
                    if isClear {
                        self.results.removeAll()
                        self.results = data.items
                    } else {
                        self.results.append(contentsOf: data.items)
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        
                        if isClear {
                            let indexPath = NSIndexPath(row: NSNotFound, section: 0)
                            self.tableView.scrollToRow(at: indexPath as IndexPath, at: .top, animated: false)
                        }
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

// MARK: UIScrollViewDelegate
extension ViewController: UIScrollViewDelegate {
    // 스크롤이 최하단으로 내려왔다면 추가 Pagination
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - scrollView.frame.size.height - 100) && position > 0 {
            if !(currentQuery.isEmpty) && !(APICaller.shared.isLoading) {
                currentPage += 1
                print(currentPage)
                self.fetchData(query: currentQuery, page: currentPage)
            }
        }
    }
}

// MARK: UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    // Search Event
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            print(query)
            
            // Clear & Search
            currentQuery = query
            currentPage = 1
            self.fetchData(query: currentQuery, page: currentPage, isClear: true)
            
        }
    }
    
    // Cancel Event
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.endEditing(true)
    }
}
