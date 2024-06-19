//
//  HomeCoordinator.swift
//  ShoppingApp
//
//  Created by admin on 6/19/24.
//

import SwiftUI

struct HomeCoordinator<Content: View>: View {
    
    @ObservedObject var state: HomeFlowState
    let content: () -> Content

    var body: some View {
        NavigationStack(path: $state.path) {
            ZStack {
                content()
                navigationLinks
            }
            
            .navigationDestination(for: HomeViewLink.self, destination: linkDestination)
            //.navigationDestination(for: String.self, destination: customDestination)
        }
    }

    private var navigationLinks: some View {
        // to make this link work you need to replace NavigationStack with NavigationView!

       // NavigationStack(path: $state.selectedLink, root: linkDestination)
        NavigationLink(destination: linkDestination, item: $state.selectedLink) { EmptyView() }
    }

    @ViewBuilder private func linkDestination(link: HomeViewLink) -> some View {
        EmptyView()
        
    }
}
