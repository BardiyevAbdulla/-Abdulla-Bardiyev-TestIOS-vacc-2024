//
//  MainTableViewController.swift
//  Todos
//
//  Created by admin on 3/3/25.
//

import UIKit
import Combine

class MainTableViewController: BaseViewController, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        vm.pagination.restart(keyword: searchController.searchBar.text)
        //vm.pagination.search(searchController.searchBar.text)
    }
    
    
    var vm: MainViewModel
    private var cancellables = Set<AnyCancellable>()
    
    lazy var tableView: UITableView = {
        let tb = UITableView(frame: .init(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        tb.delegate = self
        tb.dataSource = self
        tb.rowHeight = UITableView.automaticDimension
        tb.estimatedRowHeight = 80
        return tb
    }()
    
    let searchController = UISearchController(searchResultsController: nil)
        
    
    init(vm: MainViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view.addSubview(tableView)
        
        vm.pagination.restart()
        vm.$items.receive(on: DispatchQueue.main)
            .sink {[weak self] models in
            //self?.vm.todoList = models
            self?.tableView.reloadData()
            
        }
        .store(in: &cancellables)
        
        self.view.addSubview(tableView)
        setupSearchController()
    }
    
    func setupSearchController() {
            searchController.searchResultsUpdater = self
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.placeholder = "Search Fruits"
            navigationItem.searchController = searchController
            definesPresentationContext = true
        }
    
    
}

extension MainTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
        if indexPath.row+1  == vm.items?.count ?? 1 {
            
            vm.pagination.configureHandler()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        if let item = vm.items?[indexPath.row] {
            cell = TodoCell(model: item, highlightedText: searchController.searchBar.text)
        } else {
            cell = UITableViewCell()
            cell.textLabel?.text = vm.items?[indexPath.row].title
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = vm.items?[indexPath.row] else { return }
        vm.gotoDetail(item)
        // select
    }
    
    
}










