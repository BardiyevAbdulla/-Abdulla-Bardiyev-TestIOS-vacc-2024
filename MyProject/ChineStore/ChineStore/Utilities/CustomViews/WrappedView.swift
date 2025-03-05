//
//  WrappedView.swift
//  ChineStore
//
//  Created by admin on 2/10/25.
//

import SwiftUI

struct ContentModel<Content: View>: Identifiable, Equatable {
   static func == (lhs: ContentModel<Content>, rhs: ContentModel<Content>) -> Bool {
       lhs.id == rhs.id
   }
   
   var id: String = UUID().uuidString
   var content: Content
}

struct ViewWrapping<Content: View>: View {
   // var tags: [String]
    var models: [ContentModel<Content>]
    
    @State private var totalHeight
          = CGFloat.zero       // << variant for ScrollView/List
    //    = CGFloat.infinity   // << variant for VStack

    init( contents: [Content]) {
        models = []
        for item in contents {
            models.append(.init(content: item))
        }
   // self.tags = tags
   
}
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)// << variant for ScrollView/List
        //.frame(maxHeight: totalHeight) // << variant for VStack
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.models) { item in
                item.content
                //self.item(for: tags[i])
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if item == self.models.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if item == self.models.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }.background(viewHeightReader($totalHeight))
    }

    
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}
