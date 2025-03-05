//
//  UserDetailView.swift
//  Todos
//
//  Created by admin on 3/4/25.
//

import UIKit
import Combine

class UserDetailView: BaseViewController {
    
var vm: UserDetailViewModel

    var cancelable = Set<AnyCancellable>()
    lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.dataSource = self
        tb.delegate = self
        tb.separatorStyle = .none
        return tb
    }()
    
    lazy var nameLB: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 18)
        l.numberOfLines = 0
        l.lineBreakMode = .byWordWrapping
        l.textAlignment = .natural
        return l
    }()
    
    init(vm: UserDetailViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
        
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        vm.$userModel
            .receive(on: DispatchQueue.main)
            .sink {[weak self] model in
                guard let self  else { return }
                vm.fillArray()
                nameLB.text = vm.todo?.title
                tableView.reloadData()

            }.store(in: &cancelable)
        
        setupView()
        self.navigationItem.leftBarButtonItem = .init(image: .init(systemName: "chevron.left"), style: .done, target: self, action: #selector(backTapped))
    }
    
    func setupView() {
       
        self.view.addSubviews(tableView, nameLB)
        nameLB.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 90, paddingLeft: 10, paddingRight: 10, height: 60)
        tableView.anchor(top: nameLB.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 4, paddingLeft: 10, paddingBottom: 20, paddingRight: 10)
        
       return
        
        
       
    
        
    }
    
    @objc func backTapped() {
        //navigationController?.popViewController(animated: true)
        vm.navigationPasser.send(.back)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension UserDetailView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        vm.array.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.array[section].aa.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Cell(model: vm.array[indexPath.section].aa[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let customHeader = UILabel()
        customHeader.text = vm.array[section].section
        customHeader.backgroundColor = .white
        return customHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40 // Adjust height
    }
    
    
    
}




