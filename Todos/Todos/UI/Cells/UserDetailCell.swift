//
//  UserDetailCell.swift
//  Todos
//
//  Created by admin on 3/5/25.
//

import Foundation
import UIKit

class Cell: UITableViewCell {
    let model: CellData
    
    lazy var nameLB: UILabel = {
        let l = UILabel()
        l.font = .boldSystemFont(ofSize: 18)
        l.numberOfLines = 0
        l.lineBreakMode = .byWordWrapping
        return l
    }()
    
    lazy var titleLB: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14)
        l.textColor = .gray
        l.numberOfLines = 0
//        l.lineBreakMode = .byWordWrapping
        
        return l
    }()
    
    init(model: CellData) {
        self.model = model
        super.init(style: .default, reuseIdentifier: "Cell")
        initView()
        
    }
    
    func initView() {
        nameLB.text = model.name
        titleLB.text = model.title
       
        contentView.addSubviews(nameLB, titleLB)
        let width = titleLB.intrinsicContentSize.width
        
        titleLB.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, paddingLeft: 10, paddingRight: 10, width: width+6, height: 28)
        
       
        nameLB.anchor(top: contentView.topAnchor, left: titleLB.rightAnchor, right: contentView.rightAnchor, paddingRight: 10, height: 28)
        
       
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
