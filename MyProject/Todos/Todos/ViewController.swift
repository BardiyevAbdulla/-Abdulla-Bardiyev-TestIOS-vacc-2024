//
//  ViewController.swift
//  Todos
//
//  Created by admin on 3/3/25.
//

import UIKit



class ViewController: UIViewController, DropdownViewDelegate {
    
    private let dropdownButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select an Option", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 8
        return button
    }()
    
    private var dropdownView: DropdownView?
    private let items = ["Option 1", "Option 2", "Option 3", "Option 4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(dropdownButton)
        dropdownButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dropdownButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dropdownButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            dropdownButton.widthAnchor.constraint(equalToConstant: 200),
            dropdownButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        dropdownButton.addTarget(self, action: #selector(showDropdown), for: .touchUpInside)
    }
    
    @objc private func showDropdown() {
        if let dropdownView = dropdownView {
            dropdownView.hideDropdown()
            self.dropdownView = nil
        } else {
            let dropdown = DropdownView(items: items)
            dropdown.delegate = self
            dropdown.showDropdown(in: view, anchorView: dropdownButton)
            self.dropdownView = dropdown
        }
    }
    
    // MARK: - DropdownViewDelegate
    func dropdownView(_ dropdownView: DropdownView, didSelectItem item: String) {
        dropdownButton.setTitle(item, for: .normal)
        self.dropdownView = nil
    }
}

import UIKit

protocol DropdownViewDelegate: AnyObject {
    func dropdownView(_ dropdownView: DropdownView, didSelectItem item: String)
}

class DropdownView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView = UITableView()
    private var items: [String] = []
    weak var delegate: DropdownViewDelegate?
    
    init(items: [String]) {
        super.init(frame: .zero)
        self.items = items
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func showDropdown(in parentView: UIView, anchorView: UIView) {
        parentView.addSubview(self)
        
        let anchorFrame = anchorView.convert(anchorView.bounds, to: parentView)
        frame = CGRect(x: anchorFrame.minX, y: anchorFrame.maxY, width: anchorFrame.width, height: 150)
        
        alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }
    
    func hideDropdown() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
    // MARK: - TableView DataSource & Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.dropdownView(self, didSelectItem: items[indexPath.row])
        hideDropdown()
    }
}
