//
//  TabBarView.swift
//  ShoppingApp
//
//  Created by admin on 6/19/24.
//

import SwiftUI

struct TabBarView: View {
    @State var index = 0
    var body: some View {
        TabView(selection: $index)  {
            HomeView(vm: .init())
                .tabItem { Text("Home") }
                .tag(0)
           
            ProfileView(vm: .init())
                .tabItem {  Text("Profile") }
                .tag(1)
            
            
        }
       
    }
}

#Preview {
    TabBarView()
}
