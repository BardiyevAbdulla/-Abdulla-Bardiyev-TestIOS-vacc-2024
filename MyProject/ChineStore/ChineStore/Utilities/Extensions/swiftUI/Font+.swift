//
//  Font+.swift
//  ChineStore
//
//  Created by admin on 2/8/25.
//

import SwiftUI

extension Font {
    struct Inter {
        
        static func medium(_ size: CGFloat = 12) -> Font {
            return .custom("Inter-Medium", size: size) //  700  SFProDisplay-Bold
        }
        
        static func light(_ size: CGFloat = 12) -> Font {
            return .custom("Inter-Light", size: size) //  700  SFProDisplay-Bold
        }
        
        static func thin(_ size: CGFloat = 12) -> Font {
            return .custom("Inter-Thin", size: size) //  700  SFProDisplay-Bold
        }
        
        static func bold(_ size: CGFloat = 12) -> Font {
            return .custom("Inter-Bold", size: size) //  700  SFProDisplay-Bold
        }
        
        static func regular(_ size: CGFloat = 12) -> Font {
            return .custom("Inter-Regular", size: size) //  700  SFProDisplay-Bold
        }
        
        static func extraBold(_ size: CGFloat = 12) -> Font {
            return .custom("Inter-ExtraBold", size: size) //  700  SFProDisplay-Bold
        }
        
        static func extraLight(_ size: CGFloat = 12) -> Font {
            return .custom("Inter-ExtraLight", size: size) //  700  SFProDisplay-Bold
        }
        
        static func black(_ size: CGFloat = 12) -> Font {
            return .custom("Inter-Black", size: size) //  700  SFProDisplay-Bold
        }
        
        static func semiBold(_ size: CGFloat = 12) -> Font {
            return .custom("Inter-SemiBold", size: size) //  700
        }
        
    }
}
