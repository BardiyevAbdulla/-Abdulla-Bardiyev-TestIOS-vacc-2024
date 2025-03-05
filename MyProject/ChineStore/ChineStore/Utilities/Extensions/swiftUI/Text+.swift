//
//  Text+.swift
//  ChineStore
//
//  Created by admin on 2/9/25.
//

import SwiftUI
import UIKit


extension Text {
  
   // @available(iOS 15, *)
    init(_ text: String, changeColors: [ChangeColor]? = nil, changeFonts: [ChangeFont]? = nil, setLinks: [SetLink]? = nil) {
        let attributeString: NSMutableAttributedString = .init(string: text)
        let strNumber: NSString = text as NSString
        
        if let changeColors = changeColors {
            for changeColor in changeColors {
                let range = (strNumber).range(of: changeColor.text)
                attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: changeColor.color, range: range)
            }
        }
        
        if let changeFonts = changeFonts {
            for item in changeFonts {
                let range = (strNumber).range(of: item.text)
                attributeString.addAttribute(NSAttributedString.Key.font, value: item.font, range: range)
            }
        }
        
        if let setLinks {
            for item in setLinks {
                if let range = text.range(of: item.text) {
                    let index = text.distance(from: text.startIndex, to: range.lowerBound)
                    attributeString.addAttribute(.link, value: item.link, range: NSRange(location: index, length: item.text.count))
                    
                    attributeString.addAttribute(.underlineColor, value: UIColor.black, range: NSRange(location: index, length: item.text.count))
                }
            }
        }
        
        if #available(iOS 15, *) {
            
            let attribute = AttributedString(attributeString)
            self.init(attribute)
        }
        else {
           
            self.init(text)
            }
        
        
    }
}

struct ChangeColor {
    var text: String
    var color: UIColor
}

struct ChangeFont {
    var text: String
    var font: UIFont
}

struct SetLink {
    var text: String
    var link: String
}
