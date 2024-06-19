//
//  ProfileCoordinator.swift
//  ShoppingApp
//
//  Created by admin on 6/19/24.
//

import SwiftUI

struct ProfileCoordinator<Content: View>: View {
    @ObservedObject var state: ProfileFlowState
    let content: () -> Content

    var body: some View {
        NavigationStack(path: $state.path) {
            ZStack {
                content()
                navigationLinks
            }
            
            .navigationDestination(for: ProfileViewLink.self, destination: linkDestination)
            //.navigationDestination(for: String.self, destination: customDestination)
        }
    }
    
    private var navigationLinks: some View {
        // to make this link work you need to replace NavigationStack with NavigationView!

       // NavigationStack(path: $state.selectedLink, root: linkDestination)
        NavigationLink(destination: linkDestination, item: $state.selectedLink) { EmptyView() }
    }

    @ViewBuilder private func linkDestination(link: ProfileViewLink) -> some View {
        EmptyView()
       // return  SetDetailView(vm: .init("", setThroughThread: {_ in }))
        
//            switch link {
//            case .link(let handler):
//                SetDetailView(vm: .init("", setThroughThread: handler))
//
//            }
        
    }
    
    
}
