//
//  TodoCell.swift
//  Todos
//
//  Created by admin on 3/5/25.
//

import UIKit

class TodoCell: UITableViewCell {
    let model: any CellDataSourse
    let highlightedText: String?
    
    lazy var nameLB: UILabel = {
        let l = UILabel()
        l.font = .boldSystemFont(ofSize: 16)
        return l
    }()
    
    lazy var titleLB: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14)
        l.textColor = .gray
        l.numberOfLines = 0
        l.lineBreakMode = .byWordWrapping
        
        return l
    }()
    
    var titleAttributeString: NSMutableAttributedString
    var nameAttributeString: NSMutableAttributedString

    
    init(model: any CellDataSourse, highlightedText: String? = nil) {
        self.model = model
        self.highlightedText = highlightedText
        
        titleAttributeString = .init(string: model.title ?? "")
        nameAttributeString = .init(string: model.name ?? "")
        super.init(style: .default, reuseIdentifier: "TableViewCell")
        
        if let highlightedText, highlightedText.count > 0 {
            hintLabel(highlightedText, atribute: nameAttributeString, label: nameLB)
            hintLabel(highlightedText, atribute: titleAttributeString, label: titleLB)

        
    }
        
        
        initView()
    }
    
    func initView() {
        nameLB.attributedText = nameAttributeString
        titleLB.attributedText = titleAttributeString
       
        contentView.addSubviews(nameLB, titleLB)
        let width = nameLB.intrinsicContentSize.width
        nameLB.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, paddingLeft: 10, width: width, height: 28)
        
       
        titleLB.anchor(top: nameLB.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        
    }
    
    func hintLabel(_ highlighted: String, atribute: NSMutableAttributedString, label: UILabel) {
        let attributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.red,
        .backgroundColor: UIColor.yellow]
        
        let text = atribute.string.count > 0 ? atribute.string.lowercased() : ""
        if  let nameRange = text.range(of: highlighted.lowercased()) {
            
            let nsRange = NSRange(nameRange, in: text)
            atribute.addAttributes(attributes, range: nsRange)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
