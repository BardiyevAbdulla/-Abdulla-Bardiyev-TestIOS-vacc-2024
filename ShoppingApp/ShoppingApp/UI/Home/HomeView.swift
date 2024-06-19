//
//  HomeView.swift
//  ShoppingApp
//
//  Created by admin on 6/19/24.
//

import SwiftUI

open class HomeFlowState: ObservableObject {
    @Published var path = NavigationPath()
    @Published var presentedItem: HomeViewLink?
    @Published var coverItem: HomeViewLink?
    @Published var selectedLink: HomeViewLink? // old style
}

struct HomeView: View {
    @StateObject var vm: HomeViewModel
    
    var body: some View {
        HomeCoordinator(state: vm, content: contentView)
        
    }
    
    func contentView() -> some View {
        VStack {
            Text("sa")
        }
    }
}

#Preview {
    HomeView(vm: .init())
}
